<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use App\Models\Usuario;
use App\Services\AuditoriaService;

class UsuarioController extends Controller
{
    public function index()
    {
        return response()->json(Usuario::with('rol')->get());
    }

    public function findByRole($nombre)
    {
        return response()->json(Usuario::whereHas('rol', function ($q) use ($nombre) {
            $q->where('nombre', $nombre);
        })->with('rol')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'rol_id' => 'required|exists:roles,id',
            'nombres' => 'required|string',
            'apellidos' => 'required|string',
            'correo' => 'required|email|unique:usuarios',
            'contrasena' => 'required|string|min:6',
            'telefono' => 'nullable|string',
            'estado' => 'nullable|string',
            'ci' => 'nullable|string|unique:usuarios',
        ]);

        $data['contrasena_hash'] = Hash::make($data['contrasena']);
        unset($data['contrasena']);

        $usuario = Usuario::create($data);

        AuditoriaService::log(
            auth('api')->id(),
            'CREAR_USUARIO',
            'Usuario',
            $usuario->id,
            "Usuario creado: {$usuario->nombres} {$usuario->apellidos} ({$usuario->correo})",
            null,
            ['nombres' => $usuario->nombres, 'apellidos' => $usuario->apellidos, 'correo' => $usuario->correo, 'rol_id' => $usuario->rol_id]
        );

        return response()->json($usuario, 201);
    }

    public function show($id)
    {
        return response()->json(
            Usuario::with([
                'rol',
                'inscripciones.curso',
                'certificados.curso',
                'intentos_evaluacion.evaluacion.curso',
                'intentos_evaluacion.evaluacion.preguntas.respuestas',
                'dispositivos',
                'auditoria_logs',
            ])->findOrFail($id)
        );
    }

    public function update(Request $request, $id)
    {
        $usuario = Usuario::findOrFail($id);

        // Validate only provided fields, keep existing data untouched
        $validated = $request->validate([
            'rol_id' => 'sometimes|exists:roles,id',
            'nombres' => 'sometimes|string',
            'apellidos' => 'sometimes|string',
            'correo' => ['sometimes', 'email', Rule::unique('usuarios')->ignore($usuario->id)],
            'telefono' => 'sometimes|nullable|string',
            'estado' => 'sometimes|nullable|string',
            'ci' => ['sometimes', 'nullable', 'string', Rule::unique('usuarios')->ignore($usuario->id)],
            'imagen_perfil' => 'sometimes|nullable|string',
            'contrasena' => 'sometimes|string|min:6',
        ]);

        // Handle password hashing if provided
        if (isset($validated['contrasena'])) {
            $validated['contrasena_hash'] = Hash::make($validated['contrasena']);
            unset($validated['contrasena']);
        }

        $anterior = $usuario->only(['nombres', 'apellidos', 'correo', 'telefono', 'estado', 'ci', 'rol_id']);

        // Update only the fields that were validated (present in request)
        $usuario->update($validated);

        AuditoriaService::log(
            auth('api')->id(),
            'ACTUALIZAR_USUARIO',
            'Usuario',
            $usuario->id,
            "Usuario actualizado: {$usuario->nombres} {$usuario->apellidos} ({$usuario->correo})",
            $anterior,
            $usuario->only(['nombres', 'apellidos', 'correo', 'telefono', 'estado', 'ci', 'rol_id'])
        );

        return response()->json($usuario->load('rol'));
    }

    public function destroy($id)
    {
        $usuario = Usuario::findOrFail($id);

        AuditoriaService::log(
            auth('api')->id(),
            'ELIMINAR_USUARIO',
            'Usuario',
            $usuario->id,
            "Usuario eliminado: {$usuario->nombres} {$usuario->apellidos} ({$usuario->correo})",
            ['nombres' => $usuario->nombres, 'apellidos' => $usuario->apellidos, 'correo' => $usuario->correo, 'rol_id' => $usuario->rol_id]
        );

        $usuario->delete();
        return response()->json(['message' => 'Usuario eliminado correctamente']);
    }

    public function getProfile()
    {
        return response()->json(auth('api')->user()->load('rol'));
    }

    public function updateProfile(Request $request)
    {
        $usuario = auth('api')->user();

        $request->validate([
            'ci' => ['sometimes', 'nullable', 'string', Rule::unique('usuarios')->ignore($usuario->id)],
        ]);

        $data = $request->except(['rol_id', 'estado', 'correo_verificado', 'google_id']);

        if (isset($data['contrasena'])) {
            $data['contrasena_hash'] = Hash::make($data['contrasena']);
            unset($data['contrasena']);
        }

        $usuario->update($data);
        return response()->json($usuario);
    }
}
