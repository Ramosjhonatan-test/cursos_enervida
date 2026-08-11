<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\IntentoEvaluacion;
use App\Models\Evaluacion;
use App\Models\Certificado;
use App\Models\Curso;
use Illuminate\Support\Str;
use App\Services\AuditoriaService;

class IntentoEvaluacionController extends Controller
{
    public function index()
    {
        return response()->json(IntentoEvaluacion::with(['usuario', 'evaluacion.preguntas.respuestas', 'evaluacion.curso'])->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'evaluacion_id' => 'required|exists:evaluaciones,id',
            'nota' => 'nullable|numeric',
            'fecha_inicio' => 'nullable',
            'fecha_fin' => 'nullable',
            'aprobado' => 'boolean',
            'respuestas_seleccionadas' => 'nullable|array',
        ]);
        $data['usuario_id'] = auth('api')->id();

        if (!empty($data['fecha_inicio'])) {
            $data['fecha_inicio'] = \Carbon\Carbon::parse($data['fecha_inicio'])->toDateTimeString();
        }
        if (!empty($data['fecha_fin'])) {
            $data['fecha_fin'] = \Carbon\Carbon::parse($data['fecha_fin'])->toDateTimeString();
        }

        $intento = IntentoEvaluacion::create($data);

        $certificado = null;
        if ($intento->aprobado) {
            $evaluacion = Evaluacion::find($intento->evaluacion_id);
            if ($evaluacion) {
                $cursoId = $evaluacion->curso_id;
                $usuarioId = $intento->usuario_id;

                // Check if a certificate already exists for this user and course
                $existeCertificado = Certificado::where('usuario_id', $usuarioId)
                    ->where('curso_id', $cursoId)
                    ->first();

                if (!$existeCertificado) {
                    $curso = Curso::findOrFail($cursoId);
                    $codigo = $this->generarCodigoCertificado($curso);

                    $certificado = Certificado::create([
                        'usuario_id' => $usuarioId,
                        'curso_id' => $cursoId,
                        'codigo_certificado' => $codigo,
                        'pdf_url' => '', // Will be dynamically generated when downloaded
                    ]);
                } else {
                    $certificado = $existeCertificado;
                }
            }
        }

        $responseData = $intento->toArray();
        if ($certificado) {
            $responseData['certificado'] = $certificado;
        }

        AuditoriaService::log(
            $intento->usuario_id,
            'COMPLETAR_EVALUACION',
            'IntentoEvaluacion',
            $intento->id,
            "Evaluación completada: evaluacion_id={$intento->evaluacion_id} — nota={$intento->nota}% — " . ($intento->aprobado ? 'APROBADO' : 'REPROBADO') . ($certificado ? ' — Certificado generado: ' . $certificado->codigo_certificado : '')
        );

        return response()->json($responseData, 201);
    }

    public function show($id)
    {
        return response()->json(IntentoEvaluacion::with(['usuario', 'evaluacion.preguntas.respuestas'])->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $intento = IntentoEvaluacion::findOrFail($id);
        $intento->update($request->all());
        return response()->json($intento);
    }

    public function destroy($id)
    {
        $intento = IntentoEvaluacion::findOrFail($id);

        AuditoriaService::log(
            auth('api')->id(),
            'ELIMINAR_INTENTO_EVALUACION',
            'IntentoEvaluacion',
            $intento->id,
            "Intento eliminado: usuario_id={$intento->usuario_id} evaluacion_id={$intento->evaluacion_id}",
            $intento->toArray()
        );

        $intento->delete();
        return response()->json(['message' => 'Intento eliminado']);
    }

    /**
     * Genera la abreviatura de 2 o 3 letras a partir del slug del curso.
     */
    private function obtenerAbreviaturaDesdeSlug(string $slug): string
    {
        $curso = Curso::where('slug', $slug)->first();
        if ($curso) {
            return $curso->obtenerPrefijoCertificado();
        }

        $palabras = array_filter(
            preg_split('/[^a-z0-9]+/i', $slug),
            fn($p) => !in_array(strtolower($p), ['de', 'con', 'y', 'a', 'la', 'el', 'en', 'para', 'del', 'los', 'las', 'por', 'al', 'lo'])
        );

        $palabras = array_values($palabras);
        if (count($palabras) >= 3) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1) . substr($palabras[2], 0, 1));
        }
        if (count($palabras) === 2) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1));
        }
        if (count($palabras) === 1) {
            return strtoupper(substr($palabras[0], 0, 3));
        }

        return strtoupper(substr($slug, 0, 3));
    }

    /**
     * Genera el código único del certificado bajo la norma XXVVAANNNN
     */
    private function generarCodigoCertificado(Curso $curso): string
    {
        // 1. Abreviatura (XX)
        $xx = $this->obtenerAbreviaturaDesdeSlug($curso->slug);

        // 2. Edición del curso (VV)
        $vv = sprintf('%02d', $curso->edicion_actual ?? 1);

        // 3. Año (AA)
        $aa = now()->format('y');

        // Prefijo completo: ej. BS0226
        $prefijo = $xx . $vv . $aa;

        // 4. Correlativo del participante (NNNN)
        $ultimoCertificado = Certificado::where('codigo_certificado', 'like', $prefijo . '%')
            ->orderBy('codigo_certificado', 'desc')
            ->first();

        $siguiente = 1;
        if ($ultimoCertificado) {
            $ultimoCorrelativo = substr($ultimoCertificado->codigo_certificado, -4);
            if (is_numeric($ultimoCorrelativo)) {
                $siguiente = intval($ultimoCorrelativo) + 1;
            }
        }

        $nnnn = sprintf('%04d', $siguiente);

        return $prefijo . $nnnn;
    }
}
