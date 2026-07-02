<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pregunta;

class PreguntaController extends Controller
{
    public function index()
    {
        return response()->json(Pregunta::with('respuestas')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'evaluacion_id' => 'required|exists:evaluaciones,id',
            'pregunta' => 'required|string',
            'tipo_pregunta' => 'required|string',
            'orden' => 'nullable|integer',
            'puntos' => 'nullable|numeric',
        ]);
        return response()->json(Pregunta::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(Pregunta::with('respuestas')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $pregunta = Pregunta::findOrFail($id);
        $pregunta->update($request->all());
        return response()->json($pregunta);
    }

    public function destroy($id)
    {
        Pregunta::findOrFail($id)->delete();
        return response()->json(['message' => 'Pregunta eliminada']);
    }
}
