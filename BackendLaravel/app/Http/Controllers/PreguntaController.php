<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pregunta;
use App\Models\Respuesta;

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
            'tipo_pregunta' => 'required|in:MULTIPLE_CHOICE,TRUE_FALSE',
            'orden' => 'nullable|integer',
            'puntos' => 'nullable|numeric',
        ]);

        $pregunta = Pregunta::create($data);

        if ($data['tipo_pregunta'] === 'TRUE_FALSE') {
            Respuesta::create([
                'pregunta_id' => $pregunta->id,
                'respuesta' => 'Verdadero',
                'es_correcta' => false,
            ]);
            Respuesta::create([
                'pregunta_id' => $pregunta->id,
                'respuesta' => 'Falso',
                'es_correcta' => false,
            ]);
        }

        return response()->json(Pregunta::with('respuestas')->find($pregunta->id), 201);
    }

    public function show($id)
    {
        return response()->json(Pregunta::with('respuestas')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $pregunta = Pregunta::findOrFail($id);

        $data = $request->validate([
            'pregunta' => 'sometimes|required|string',
            'tipo_pregunta' => 'sometimes|required|in:MULTIPLE_CHOICE,TRUE_FALSE',
            'orden' => 'nullable|integer',
            'puntos' => 'nullable|numeric',
        ]);

        $previousType = $pregunta->tipo_pregunta;
        $pregunta->update($data);

        if (isset($data['tipo_pregunta']) && $data['tipo_pregunta'] === 'TRUE_FALSE' && $previousType !== 'TRUE_FALSE') {
            $pregunta->respuestas()->delete();
            Respuesta::create([
                'pregunta_id' => $pregunta->id,
                'respuesta' => 'Verdadero',
                'es_correcta' => false,
            ]);
            Respuesta::create([
                'pregunta_id' => $pregunta->id,
                'respuesta' => 'Falso',
                'es_correcta' => false,
            ]);
        }

        return response()->json(Pregunta::with('respuestas')->findOrFail($id));
    }

    public function destroy($id)
    {
        Pregunta::findOrFail($id)->delete();
        return response()->json(['message' => 'Pregunta eliminada']);
    }
}
