<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Inscripcion;

class InscripcionController extends Controller
{
    public function index()
    {
        return response()->json(Inscripcion::with(['usuario', 'curso'])->get());
    }

    public function findMyInscripciones()
    {
        $userId = auth('api')->id();
        return response()->json(Inscripcion::where('usuario_id', $userId)->with('curso')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id',
            'usuario_id' => 'nullable|exists:usuarios,id',
            'estado' => 'nullable|string',
        ]);

        // Si la solicitud viene con usuario_id (admin creando inscripción directa), usarlo
        // Si no, usar el usuario autenticado
        if (empty($data['usuario_id'])) {
            $data['usuario_id'] = auth('api')->id();
        }

        // Si no se especifica el estado, el estado por defecto es PENDIENTE
        if (empty($data['estado'])) {
            $data['estado'] = 'PENDIENTE';
        }

        // Validar si ya existe la inscripción para evitar duplicados
        $exists = Inscripcion::where('usuario_id', $data['usuario_id'])
            ->where('curso_id', $data['curso_id'])
            ->exists();

        if ($exists) {
            return response()->json([
                'message' => 'El estudiante ya está inscrito en este curso o tiene una solicitud pendiente.'
            ], 422);
        }

        return response()->json(Inscripcion::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(Inscripcion::with(['usuario', 'curso'])->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $inscripcion = Inscripcion::findOrFail($id);
        $inscripcion->update($request->all());
        return response()->json($inscripcion);
    }

    public function destroy($id)
    {
        Inscripcion::findOrFail($id)->delete();
        return response()->json(['message' => 'Inscripción eliminada']);
    }
}
