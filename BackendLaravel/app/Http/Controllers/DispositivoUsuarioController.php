<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DispositivoUsuario;

class DispositivoUsuarioController extends Controller
{
    public function index()
    {
        return response()->json(DispositivoUsuario::with('usuario')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'usuario_id' => 'required|integer',
            'fingerprint' => 'required|string',
            'navegador' => 'nullable|string',
            'sistema_operativo' => 'nullable|string',
            'nombre_dispositivo' => 'nullable|string',
        ]);

        $dispositivo = DispositivoUsuario::create($request->all());

        return response()->json($dispositivo, 201);
    }

    public function show($id)
    {
        $dispositivo = DispositivoUsuario::with('usuario')->find($id);

        if (!$dispositivo) {
            return response()->json(['message' => 'Dispositivo no encontrado'], 404);
        }

        return response()->json($dispositivo);
    }

    public function update(Request $request, $id)
    {
        $dispositivo = DispositivoUsuario::find($id);

        if (!$dispositivo) {
            return response()->json(['message' => 'Dispositivo no encontrado'], 404);
        }

        $dispositivo->update($request->all());

        return response()->json($dispositivo);
    }

    public function destroy($id)
    {
        $dispositivo = DispositivoUsuario::find($id);

        if (!$dispositivo) {
            return response()->json(['message' => 'Dispositivo no encontrado'], 404);
        }

        $dispositivo->delete();

        return response()->json(['message' => 'Dispositivo eliminado con éxito']);
    }

    public function liberate($userId)
    {
        DispositivoUsuario::where('usuario_id', $userId)
            ->where('activo', true)
            ->update(['activo' => false]);

        return response()->json(['message' => 'Dispositivos liberados con éxito']);
    }
}
