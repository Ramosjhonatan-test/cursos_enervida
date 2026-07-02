<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Usuario;
use App\Models\TokenRecuperacion;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $password = $request->password ?? $request->contrasena_hash ?? $request->contrasena;
        
        $data = $request->all();
        $data['password'] = $password;

        $validator = Validator::make($data, [
            'nombres' => 'required|string|max:255',
            'apellidos' => 'required|string|max:255',
            'correo' => 'required|string|email|max:255|unique:usuarios',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'errors' => $validator->errors()], 400);
        }

        $rol = \App\Models\Rol::where('nombre', 'estudiante')->first();
        $rol_id = $rol ? $rol->id : 2;

        $usuario = Usuario::create([
            'rol_id' => $rol_id,
            'nombres' => $request->nombres,
            'apellidos' => $request->apellidos,
            'correo' => $request->correo,
            'contrasena_hash' => Hash::make($password),
            'estado' => 'ACTIVO',
            'correo_verificado' => false,
        ]);

        $token = auth('api')->login($usuario);

        // --- AUDITORIA ---
        \App\Services\AuditoriaService::log(
            $usuario->id,
            'REGISTRO',
            'Usuario',
            $usuario->id,
            "Nuevo registro: {$usuario->nombres} {$usuario->apellidos} ({$usuario->correo})",
            null,
            ['nombres' => $usuario->nombres, 'correo' => $usuario->correo],
            $request
        );
        \App\Services\AuditoriaService::registrarDispositivo($usuario->id, $request);

        return $this->respondWithToken($token, $usuario);
    }

    public function login(Request $request)
    {
        $correo = $request->email ?? $request->correo;
        $password = $request->password ?? $request->contrasena;

        $usuario = Usuario::where('correo', $correo)->first();

        if (!$usuario || !Hash::check($password, $usuario->contrasena_hash)) {
            \App\Services\AuditoriaService::log(
                null,
                'LOGIN_FALLIDO',
                'Usuario',
                null,
                "Intento de login fallido para: {$correo}",
                null,
                ['correo' => $correo],
                $request
            );
            return response()->json(['error' => 'Credenciales invalidas'], 401);
        }

        // --- CONTROL DE DISPOSITIVO UNICO ---
        $dispositivoActivo = $usuario->dispositivos()->where('activo', true)->first();
        $fingerprintActual = md5($request->ip() . $request->header('User-Agent', ''));

        if ($dispositivoActivo && $dispositivoActivo->fingerprint !== $fingerprintActual) {
            \App\Services\AuditoriaService::log(
                $usuario->id,
                'LOGIN_DISPOSITIVO_NO_AUTORIZADO',
                'Usuario',
                $usuario->id,
                "Intento de acceso desde dispositivo no autorizado. IP: {$request->ip()}",
                null,
                ['fingerprint_intento' => $fingerprintActual, 'fingerprint_registrado' => $dispositivoActivo->fingerprint],
                $request
            );
            return response()->json([
                'error' => 'DISPOSITIVO_NO_AUTORIZADO',
                'message' => 'Esta cuenta ya esta vinculada a otro dispositivo. Contacta al administrador para liberar la cuenta.',
            ], 403);
        }

        $usuario->ultimo_login = now();
        $usuario->save();

        $token = auth('api')->login($usuario);

        // --- AUDITORIA ---
        \App\Services\AuditoriaService::log(
            $usuario->id,
            'LOGIN',
            'Usuario',
            $usuario->id,
            "Inicio de sesion: {$usuario->nombres} {$usuario->apellidos}",
            null,
            null,
            $request
        );
        \App\Services\AuditoriaService::registrarDispositivo($usuario->id, $request);

        return $this->respondWithToken($token, $usuario);
    }

    public function googleLogin(Request $request)
    {
        $token = $request->token ?? $request->access_token;

        if (!$token) {
            return response()->json(['error' => 'Token de Google requerido'], 400);
        }

        try {
            $isJwt = (substr_count($token, '.') === 2);
            $googleUser = null;

            if ($isJwt) {
                $response = \Illuminate\Support\Facades\Http::get('https://oauth2.googleapis.com/tokeninfo', [
                    'id_token' => $token
                ]);

                if ($response->failed()) {
                    \Illuminate\Support\Facades\Log::error('Google ID Token Failed: ' . $response->body());
                    return response()->json(['error' => 'ID Token de Google invalido', 'details' => $response->json()], 401);
                }
                
                $googleUser = $response->json();

                $googleClientId = env('GOOGLE_CLIENT_ID');
                if (isset($googleUser['aud']) && $googleUser['aud'] !== $googleClientId) {
                    return response()->json(['error' => 'Audience de Google invalido'], 401);
                }
            } else {
                $response = \Illuminate\Support\Facades\Http::withToken($token)
                    ->get('https://www.googleapis.com/oauth2/v3/userinfo');
                
                if ($response->failed()) {
                    \Illuminate\Support\Facades\Log::error('Google Access Token Failed: ' . $response->body());
                    return response()->json(['error' => 'Access Token de Google invalido', 'details' => $response->json()], 401);
                }

                $googleUser = $response->json();
            }

            if (!isset($googleUser['email'])) {
                return response()->json(['error' => 'No se pudo obtener el email de Google'], 401);
            }

            $usuario = Usuario::where('correo', $googleUser['email'])->first();
            $esNuevo = false;

            if (!$usuario) {
                // Registro nuevo via Google — se le asigna el primer dispositivo libremente
                $rol = \App\Models\Rol::where('nombre', 'estudiante')->first();
                $rol_id = $rol ? $rol->id : 2;

                $usuario = Usuario::create([
                    'rol_id'          => $rol_id,
                    'nombres'         => $googleUser['given_name'] ?? $googleUser['name'] ?? '',
                    'apellidos'       => $googleUser['family_name'] ?? '',
                    'correo'          => $googleUser['email'],
                    'contrasena_hash' => Hash::make(Str::random(32)), // Contrasena aleatoria: el usuario nunca la usa
                    'google_id'       => $googleUser['sub'] ?? null,
                    'imagen_perfil'   => $googleUser['picture'] ?? null,
                    'estado'          => 'ACTIVO',
                    'correo_verificado' => true,
                ]);
                $esNuevo = true;
            } else {
                // Usuario existente — verificar dispositivo vinculado
                if (!$usuario->google_id) {
                    $usuario->google_id = $googleUser['sub'] ?? null;
                    $usuario->imagen_perfil = $usuario->imagen_perfil ?? ($googleUser['picture'] ?? null);
                }

                // --- CONTROL DE DISPOSITIVO UNICO (igual que login manual) ---
                $dispositivoActivo = $usuario->dispositivos()->where('activo', true)->first();
                $fingerprintActual = md5($request->ip() . $request->header('User-Agent', ''));

                if ($dispositivoActivo && $dispositivoActivo->fingerprint !== $fingerprintActual) {
                    \App\Services\AuditoriaService::log(
                        $usuario->id,
                        'LOGIN_GOOGLE_DISPOSITIVO_NO_AUTORIZADO',
                        'Usuario',
                        $usuario->id,
                        "Intento de acceso Google desde dispositivo no autorizado. IP: {$request->ip()}",
                        null,
                        ['fingerprint_intento' => $fingerprintActual, 'fingerprint_registrado' => $dispositivoActivo->fingerprint],
                        $request
                    );
                    return response()->json([
                        'error'   => 'DISPOSITIVO_NO_AUTORIZADO',
                        'message' => 'Esta cuenta ya esta vinculada a otro dispositivo. Contacta al administrador para liberar la cuenta.',
                    ], 403);
                }
            }

            $usuario->ultimo_login = now();
            $usuario->save();

            $jwtToken = auth('api')->login($usuario);

            // --- AUDITORIA ---
            $accion = $esNuevo ? 'REGISTRO_GOOGLE' : 'LOGIN_GOOGLE';
            $desc = $esNuevo
                ? "Registro nuevo via Google: {$usuario->nombres} {$usuario->apellidos} ({$usuario->correo})"
                : "Login via Google: {$usuario->nombres} {$usuario->apellidos}";

            \App\Services\AuditoriaService::log(
                $usuario->id,
                $accion,
                'Usuario',
                $usuario->id,
                $desc,
                null,
                null,
                $request
            );
            \App\Services\AuditoriaService::registrarDispositivo($usuario->id, $request);

            return $this->respondWithToken($jwtToken, $usuario);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Google Exception: ' . $e->getMessage());
            return response()->json(['error' => 'Error al verificar token con Google: ' . $e->getMessage()], 401);
        }
    }

    public function refresh()
    {
        return $this->respondWithToken(auth('api')->refresh(), auth('api')->user());
    }

    public function logout()
    {
        $usuario = auth('api')->user();

        if ($usuario) {
            \App\Services\AuditoriaService::log(
                $usuario->id,
                'LOGOUT',
                'Usuario',
                $usuario->id,
                "Cierre de sesion: {$usuario->nombres} {$usuario->apellidos}",
                null,
                null,
                request()
            );
        }

        auth('api')->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }

    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $usuario = Usuario::where('correo', $request->email)->first();

        if (!$usuario) {
            return response()->json(['message' => 'Si el correo existe, recibiras un enlace de recuperacion']);
        }

        TokenRecuperacion::where('usuario_id', $usuario->id)->delete();

        $token = Str::random(64);
        TokenRecuperacion::create([
            'usuario_id' => $usuario->id,
            'token' => $token,
            'tipo' => 'RESET_PASSWORD',
            'expira_en' => now()->addHours(1),
        ]);

        $resetUrl = env('FRONTEND_URL') . '/reset-password?token=' . $token;

        Mail::raw("Hola {$usuario->nombres},\n\nHaz clic en el siguiente enlace para restablecer tu contrasena:\n{$resetUrl}\n\nEste enlace expira en 1 hora.\n\nSaludos,\nEnervida LMS", function ($message) use ($usuario) {
            $message->to($usuario->correo)
                    ->subject('Recuperacion de Contrasena - Enervida LMS');
        });

        \App\Services\AuditoriaService::log(
            $usuario->id,
            'RECUPERACION_CONTRASENA',
            'Usuario',
            $usuario->id,
            "Solicitud de recuperacion de contrasena para: {$usuario->correo}",
            null,
            null,
            $request
        );

        return response()->json(['message' => 'Si el correo existe, recibiras un enlace de recuperacion']);
    }

    public function resetPassword(Request $request)
    {
        $request->validate([
            'token' => 'required|string',
            'newPassword' => 'required|string|min:6',
        ]);

        $tokenRecord = TokenRecuperacion::where('token', $request->token)
            ->where('tipo', 'RESET_PASSWORD')
            ->where('usado', false)
            ->where('expira_en', '>', now())
            ->first();

        if (!$tokenRecord) {
            return response()->json(['error' => 'Token invalido o expirado'], 400);
        }

        $usuario = Usuario::findOrFail($tokenRecord->usuario_id);
        $usuario->contrasena_hash = Hash::make($request->newPassword);
        $usuario->save();

        $tokenRecord->usado = true;
        $tokenRecord->save();

        \App\Services\AuditoriaService::log(
            $usuario->id,
            'CONTRASENA_RESTABLECIDA',
            'Usuario',
            $usuario->id,
            "Contrasena restablecida para: {$usuario->correo}",
            null,
            null,
            $request
        );

        return response()->json(['message' => 'Contrasena actualizada correctamente']);
    }

    public function verifyEmail(Request $request)
    {
        $token = $request->query('token');

        $tokenRecord = TokenRecuperacion::where('token', $token)
            ->where('tipo', 'VERIFY_EMAIL')
            ->where('usado', false)
            ->where('expira_en', '>', now())
            ->first();

        if (!$tokenRecord) {
            return response()->json(['error' => 'Token invalido o expirado'], 400);
        }

        $usuario = Usuario::findOrFail($tokenRecord->usuario_id);
        $usuario->correo_verificado = true;
        $usuario->save();

        $tokenRecord->usado = true;
        $tokenRecord->save();

        return response()->json(['message' => 'Correo verificado exitosamente']);
    }

    protected function respondWithToken($token, $usuario = null)
    {
        return response()->json([
            'access_token' => $token,
            'refresh_token' => $token,
            'user' => $usuario ? $usuario->load('rol') : null,
            'expires_in' => auth('api')->factory()->getTTL() * 60
        ]);
    }
}
