<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Evaluacion;

class EvaluacionController extends Controller
{
    public function index()
    {
        return response()->json(Evaluacion::with('curso')->withCount('preguntas')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id',
            'titulo' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'nota_aprobacion' => 'required|numeric',
            'tiempo_limite' => 'nullable|integer',
            'intentos_permitidos' => 'required|integer',
        ]);

        $evaluacion = Evaluacion::create($data);
        return response()->json($evaluacion, 201);
    }

    public function show($id)
    {
        return response()->json(Evaluacion::with(['curso', 'preguntas.respuestas'])->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $evaluacion = Evaluacion::findOrFail($id);
        $evaluacion->update($request->all());
        return response()->json($evaluacion);
    }

    public function destroy($id)
    {
        $evaluacion = Evaluacion::findOrFail($id);
        $evaluacion->delete();
        return response()->json(['message' => 'Evaluación eliminada']);
    }
}
