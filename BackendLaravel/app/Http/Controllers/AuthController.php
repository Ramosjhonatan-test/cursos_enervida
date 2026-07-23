<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Usuario;
use App\Models\TokenRecuperacion;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use App\Mail\NotificacionMailable;
use App\Models\AuditoriaLog;

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

        // Contar intentos fallidos recientes (ventana 30 minutos o desde último login exitoso)
        $failedCount = $this->getFailedAttempts($correo);

        // Debug logging para trazar intentos y decisiones
        Log::info("AuthController@login: intento de login para: {$correo}", [
            'failedCount' => $failedCount,
            'ip' => $request->ip(),
            'user_agent' => $request->header('User-Agent', ''),
        ]);

        $usuario = Usuario::where('correo', $correo)->first();

        // Usuario inexistente: registrar intento fallido y advertir / bloquear según conteo
        if (!$usuario) {
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

            Log::info("AuthController@login: usuario no encontrado para {$correo}", ['failedCount_plus_one' => $failedCount + 1]);

            if ($failedCount + 1 >= 3) {
                return response()->json(['error' => 'Se han detectado demasiados intentos fallidos. Acceso restringido temporalmente.'], 403);
            }

            $remaining = 3 - ($failedCount + 1);
            return response()->json(['error' => "Credenciales invalidas. "], 401);
            //return response()->json(['error' => "Credenciales invalidas. Te quedan {$remaining} " . ($remaining === 1 ? 'intento' : 'intentos')], 401);
        }

        // Verificar si la cuenta ya está bloqueada
        if ($usuario->estado === 'BLOQUEADO') {
            \App\Services\AuditoriaService::log(
                $usuario->id,
                'LOGIN_BLOQUEADO',
                'Usuario',
                $usuario->id,
                "Intento de acceso a cuenta bloqueada: {$correo}",
                null,
                null,
                $request
            );
            Log::warning("AuthController@login: intento de acceso a cuenta BLOQUEADA para usuario_id={$usuario->id}", ['correo' => $correo]);
            return response()->json(['error' => 'Tu cuenta está bloqueada por seguridad debido a múltiples intentos fallidos. Contacta al administrador.'], 403);
        }

        // Verificar contraseña
        if (!Hash::check($password, $usuario->contrasena_hash)) {
            \App\Services\AuditoriaService::log(
                $usuario->id,
                'LOGIN_FALLIDO',
                'Usuario',
                $usuario->id,
                "Contraseña incorrecta para: {$correo}",
                null,
                ['correo' => $correo],
                $request
            );

            Log::info("AuthController@login: contraseña incorrecta para usuario_id={$usuario->id}", ['failedCount' => $failedCount]);

            $currentCount = $failedCount + 1;
            if ($currentCount >= 3) {
                $usuario->estado = 'BLOQUEADO';
                $usuario->save();

                Log::warning("AuthController@login: bloqueando cuenta usuario_id={$usuario->id} tras {$currentCount} intentos fallidos", ['correo' => $correo]);

                // Enviar correo notificando bloqueo
                try {
                    Mail::to($usuario->correo)->send(new NotificacionMailable(
                        'Cuenta Bloqueada por Seguridad',
                        'Detectamos múltiples intentos fallidos de inicio de sesión en tu cuenta. Por motivos de seguridad, hemos bloqueado el acceso temporalmente.',
                        'Contactar soporte',
                        env('FRONTEND_URL', config('app.url')),
                        'critical',
                        $usuario
                    ));
                    Log::info("AuthController@login: intento de envio de correo de bloqueo para usuario_id={$usuario->id}");
                } catch (\Exception $e) {
                    \Illuminate\Support\Facades\Log::warning('Error enviando correo de bloqueo: ' . $e->getMessage());
                }

                \App\Services\AuditoriaService::log(
                    $usuario->id,
                    'CUENTA_BLOQUEADA',
                    'Usuario',
                    $usuario->id,
                    "Cuenta bloqueada automaticamente tras {$currentCount} intentos fallidos",
                    null,
                    null,
                    $request
                );

                return response()->json(['error' => 'Tu cuenta ha sido bloqueada tras varios intentos fallidos. Revisa tu correo'], 403);
            }

            $remaining = 3 - $currentCount;
            return response()->json(['error' => "Credenciales invalidas. Te quedan {$remaining} " . ($remaining === 1 ? 'intento' : 'intentos')], 401);
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

        Mail::to($usuario->correo)->send(new NotificacionMailable(
            'Recuperación de Contraseña',
            'Recibimos una solicitud para restablecer la contraseña de tu cuenta en Enervida LMS.',
            'Restablecer contraseña',
            $resetUrl,
            'normal',
            $usuario
        ));

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

    /**
     * Cuenta los intentos fallidos recientes para un correo.
     * Ventana: últimos 30 minutos o desde el último LOGIN exitoso.
     */
    private function getFailedAttempts(string $correo): int
    {
        $cutoff = now()->subMinutes(30);

        $lastSuccess = AuditoriaLog::where('accion', 'LOGIN')
            ->whereHas('usuario', function($q) use ($correo) {
                $q->where('correo', $correo);
            })
            ->orderBy('fecha_creacion', 'desc')
            ->first();

        $startTime = $cutoff;
        if ($lastSuccess && strtotime($lastSuccess->fecha_creacion) > strtotime($cutoff)) {
            $startTime = $lastSuccess->fecha_creacion;
        }

        $count = AuditoriaLog::where('accion', 'LOGIN_FALLIDO')
            ->where('fecha_creacion', '>', $startTime)
            ->where(function($q) use ($correo) {
                $q->whereHas('usuario', function($qq) use ($correo) { $qq->where('correo', $correo); })
                  ->orWhere('valores_nuevos', 'like', '%"correo":"' . $correo . '"%');
            })
            ->count();

        return (int) $count;
    }
}
