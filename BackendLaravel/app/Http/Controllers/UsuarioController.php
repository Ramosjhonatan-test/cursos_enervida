<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use App\Models\Usuario;

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
        return response()->json($usuario, 201);
    }

    public function show($id)
    {
        return response()->json(
            Usuario::with([
                'rol',
                'inscripciones.curso',
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

        // Update only the fields that were validated (present in request)
        $usuario->update($validated);
        return response()->json($usuario->load('rol'));
    }

    public function destroy($id)
    {
        $usuario = Usuario::findOrFail($id);
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
