<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Curso;

class CursoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json(Curso::with(['categoria', 'instructor', 'plantilla_certificado'])->get());
    }

    /**
     * Display a listing of the published resources.
     */
    public function findPublished()
    {
        return response()->json(Curso::where('publicado', true)->with(['categoria', 'instructor', 'plantilla_certificado'])->get());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'categoria_id' => 'required|exists:categorias,id',
            'instructor_id' => 'required|exists:usuarios,id',
            'titulo' => 'required|string|max:255',
            'slug' => 'required|string|unique:cursos,slug',
            'descripcion_corta' => 'nullable|string',
            'descripcion' => 'nullable|string',
            'miniatura_url' => 'nullable|string',
            'nivel' => 'nullable|string',
            'tipo_curso' => 'nullable|string',
            'certificado_habilitado' => 'nullable|boolean',
            'publicado' => 'nullable|boolean',
            'precio' => 'nullable|numeric',
            'edicion_actual' => 'nullable|integer|min:1|max:99',
        ]);

        $curso = Curso::create($validated);
        return response()->json($curso, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $curso = Curso::with(['categoria', 'instructor', 'modulos.lecciones', 'plantilla_certificado', 'evaluaciones'])->findOrFail($id);
        return response()->json($curso);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $curso = Curso::findOrFail($id);
        $curso->update($request->all());
        return response()->json($curso);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $curso = Curso::findOrFail($id);

        \Illuminate\Support\Facades\DB::transaction(function () use ($curso) {
            // 1. Delete Clases en Vivo and their Participantes
            $clases = \App\Models\ClaseEnVivo::where('curso_id', $curso->id)->get();
            foreach ($clases as $clase) {
                $clase->participantes()->delete();
                $clase->delete();
            }

            // 2. Delete Certificados associated with this course
            \App\Models\Certificado::where('curso_id', $curso->id)->delete();

            // 3. Delete Inscripciones
            $curso->inscripciones()->delete();

            // 4. Delete CertificadoPlantilla (one-to-one)
            $curso->plantilla_certificado()->delete();

            // 5. Delete Modulos and Lecciones (with lesson progress)
            $modulos = $curso->modulos;
            foreach ($modulos as $modulo) {
                $lecciones = $modulo->lecciones;
                foreach ($lecciones as $leccion) {
                    \App\Models\ProgresoLeccion::where('leccion_id', $leccion->id)->delete();
                    $leccion->delete();
                }
                $modulo->delete();
            }

            // 6. Delete Evaluaciones, Intentos, Preguntas, Respuestas
            $evaluaciones = $curso->evaluaciones;
            foreach ($evaluaciones as $evaluacion) {
                // Delete Intentos de Evaluacion
                \App\Models\IntentoEvaluacion::where('evaluacion_id', $evaluacion->id)->delete();

                // Delete Preguntas and their Respuestas
                $preguntas = $evaluacion->preguntas;
                foreach ($preguntas as $pregunta) {
                    $pregunta->respuestas()->delete();
                    $pregunta->delete();
                }
                $evaluacion->delete();
            }

            // 7. Delete the Course
            $curso->delete();
        });

        return response()->json(['message' => 'Curso y todos sus contenidos relacionados eliminados correctamente']);
    }
}
