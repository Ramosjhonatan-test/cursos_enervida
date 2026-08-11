<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Evaluacion;
use App\Services\AuditoriaService;

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

        AuditoriaService::log(
            auth('api')->id(),
            'CREAR_EVALUACION',
            'Evaluacion',
            $evaluacion->id,
            "Evaluación creada: '{$evaluacion->titulo}' para curso_id={$evaluacion->curso_id}",
            null,
            $evaluacion->toArray()
        );

        return response()->json($evaluacion, 201);
    }

    public function show($id)
    {
        $evaluacion = Evaluacion::with(['curso', 'preguntas.respuestas'])->findOrFail($id);

        if (auth('api')->check()) {
            $user = auth('api')->user();
            $user->loadMissing('rol');

            $puedeGestionarEvaluacion = $user->isAdmin() || $user->isInstructor() || $user->hasAdminModule('EVALUACIONES');

            if (!$puedeGestionarEvaluacion) {
                $userId = $user->id;
                $inscripcion = \App\Models\Inscripcion::where('usuario_id', $userId)
                    ->where('curso_id', $evaluacion->curso_id)
                    ->whereIn('estado', ['ACTIVO', 'COMPLETADO'])
                    ->first();

                if (!$inscripcion) {
                    return response()->json([
                        'message' => 'No tienes acceso a esta evaluación.'
                    ], 403);
                }
            }
        }

        return response()->json($evaluacion);
    }

    public function update(Request $request, $id)
    {
        $evaluacion = Evaluacion::findOrFail($id);
        $anterior = $evaluacion->toArray();
        
        $data = $request->only([
            'titulo', 'descripcion', 'curso_id', 'nota_aprobacion', 
            'intentos_permitidos', 'tiempo_limite'
        ]);

        $evaluacion->update($data);

        AuditoriaService::log(
            auth('api')->id(),
            'ACTUALIZAR_EVALUACION',
            'Evaluacion',
            $evaluacion->id,
            "Evaluación actualizada: '{$evaluacion->titulo}'",
            $anterior,
            $evaluacion->toArray()
        );

        return response()->json($evaluacion);
    }

    public function destroy($id)
    {
        $evaluacion = Evaluacion::findOrFail($id);

        AuditoriaService::log(
            auth('api')->id(),
            'ELIMINAR_EVALUACION',
            'Evaluacion',
            $evaluacion->id,
            "Evaluación eliminada: '{$evaluacion->titulo}' de curso_id={$evaluacion->curso_id}",
            $evaluacion->toArray()
        );

        $evaluacion->delete();
        return response()->json(['message' => 'Evaluación eliminada']);
    }
}
