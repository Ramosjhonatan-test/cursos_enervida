<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProgresoLeccion;
use App\Models\Leccion;
use App\Models\Inscripcion;

class ProgresoController extends Controller
{
    public function index()
    {
        $userId = auth('api')->id();
        return response()->json(ProgresoLeccion::where('usuario_id', $userId)->with('leccion')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'leccion_id' => 'required|exists:lecciones,id',
            'completado' => 'boolean',
            'tiempo_dedicado' => 'nullable|integer',
        ]);
        $data['usuario_id'] = auth('api')->id();

        // Crear registro de progreso de lección
        $progreso = ProgresoLeccion::create($data);

        // ---------- Actualizar porcentaje de progreso en la inscripción ----------
        // Obtener la lección y el curso asociado
        $leccion = \App\Models\Leccion::find($data['leccion_id']);
        $cursoId = $leccion->modulo->curso_id ?? null;
        $inscripcion = null;
        if ($cursoId) {
            $inscripcion = \App\Models\Inscripcion::where('usuario_id', $data['usuario_id'])
                ->where('curso_id', $cursoId)
                ->first();
        }
        if ($inscripcion) {
            // Calcular progreso
            $totalLecciones = \App\Models\Leccion::whereHas('modulo', function ($q) use ($cursoId) {
                $q->where('curso_id', $cursoId);
            })->count();
            $leccionesCompletas = \App\Models\ProgresoLeccion::where('usuario_id', $data['usuario_id'])
                ->where('completado', true)
                ->whereHas('leccion', function ($q) use ($cursoId) {
                    $q->whereHas('modulo', function ($q2) use ($cursoId) {
                        $q2->where('curso_id', $cursoId);
                    });
                })->count();
            $porcentaje = $totalLecciones > 0 ? round(($leccionesCompletas / $totalLecciones) * 100, 2) : 0;
            $inscripcion->porcentaje_progreso = $porcentaje;
            if ($porcentaje >= 100 && $inscripcion->estado !== 'COMPLETADO') {
                $inscripcion->estado = 'COMPLETADO';
                $inscripcion->fecha_completado = now();
            }
            $inscripcion->save();
        }

        // Devolver progreso y, si existe, la inscripción actualizada
        return response()->json([
            'progreso' => $progreso,
            'inscripcion' => $inscripcion,
        ], 201);
    }

    public function show($id)
    {
        return response()->json(ProgresoLeccion::with('leccion')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        // Actualizar registro de progreso
        $progreso = ProgresoLeccion::findOrFail($id);
        $progreso->update($request->all());

        // Recalcular progreso de inscripción (similar a lógica de store)
        $leccion = $progreso->leccion;
        $cursoId = $leccion->modulo->curso_id ?? null;
        $inscripcion = null;
        if ($cursoId) {
            $inscripcion = \App\Models\Inscripcion::where('usuario_id', $progreso->usuario_id)
                ->where('curso_id', $cursoId)
                ->first();
        }
        if ($inscripcion) {
            // Calcular progreso
            $totalLecciones = \App\Models\Leccion::whereHas('modulo', function ($q) use ($cursoId) {
                $q->where('curso_id', $cursoId);
            })->count();
            $leccionesCompletas = \App\Models\ProgresoLeccion::where('usuario_id', $progreso->usuario_id)
                ->where('completado', true)
                ->whereHas('leccion', function ($q) use ($cursoId) {
                    $q->whereHas('modulo', function ($q2) use ($cursoId) {
                        $q2->where('curso_id', $cursoId);
                    });
                })->count();
            $porcentaje = $totalLecciones > 0 ? round(($leccionesCompletas / $totalLecciones) * 100, 2) : 0;
            $inscripcion->porcentaje_progreso = $porcentaje;
            if ($porcentaje >= 100 && $inscripcion->estado !== 'COMPLETADO') {
                $inscripcion->estado = 'COMPLETADO';
                $inscripcion->fecha_completado = now();
            }
            $inscripcion->save();
        }

        return response()->json([
            'progreso' => $progreso,
            'inscripcion' => $inscripcion,
        ]);
    }

    public function destroy($id)
    {
        ProgresoLeccion::findOrFail($id)->delete();
        return response()->json(['message' => 'Progreso eliminado']);
    }
}
