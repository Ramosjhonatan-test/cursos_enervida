<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AuditoriaLog;

class AuditoriaController extends Controller
{
    public function index()
    {
        return response()->json(AuditoriaLog::with('usuario')->orderBy('id', 'desc')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'usuario_id'         => 'nullable|exists:usuarios,id',
            'accion'             => 'required|string',
            'entidad'            => 'nullable|string',
            'entidad_id'         => 'nullable|integer',
            'descripcion'        => 'nullable|string',
            'valores_anteriores' => 'json',
            'valores_nuevos'     => 'json',
            'direccion_ip'       => 'nullable|string',
            'user_agent'         => 'nullable|string',
            'metodo_request'     => 'nullable|string',
            'endpoint'           => 'nullable|string',
        ]);
        return response()->json(AuditoriaLog::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(AuditoriaLog::with('usuario')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $log = AuditoriaLog::findOrFail($id);
        $log->update($request->all());
        return response()->json($log);
    }

    public function destroy($id)
    {
        AuditoriaLog::findOrFail($id)->delete();
        return response()->json(['message' => 'Log eliminado']);
    }

    public function clear()
    {
        AuditoriaLog::query()->delete();
        return response()->json(['message' => 'Bitácora purgada exitosamente']);
    }
}
