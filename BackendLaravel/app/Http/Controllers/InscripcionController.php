<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Inscripcion;
use App\Models\Curso;
use App\Services\AuditoriaService;
use Carbon\Carbon;

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
        $allowedFields = [
            'curso_id',
            'usuario_id',
            'estado',
            'estado_pago',
            'metodo_pago',
            'fecha_pago',
            'comprobante_pago_url',
            'monto_pago',
            'porcentaje_progreso',
        ];

        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id',
            'usuario_id' => 'nullable|exists:usuarios,id',
            'estado' => 'nullable|string',
            'estado_pago' => 'nullable|string',
            'metodo_pago' => 'nullable|string',
            'fecha_pago' => 'nullable|date',
            'comprobante_pago_url' => 'nullable|string',
            'monto_pago' => 'nullable|numeric',
            'porcentaje_progreso' => 'nullable|numeric',
        ]);

        $data = $request->only($allowedFields);

        // Si la solicitud viene con usuario_id (admin creando inscripción directa), usarlo
        // Si no, usar el usuario autenticado
        if (empty($data['usuario_id'])) {
            $data['usuario_id'] = auth('api')->id();
        }

        // Si no se especifica el estado, el estado por defecto es PENDIENTE
        if (empty($data['estado'])) {
            $data['estado'] = 'PENDIENTE';
        }

        // Si no se especifica el estado de pago, el estado por defecto es PENDIENTE
        if (empty($data['estado_pago'])) {
            $data['estado_pago'] = 'PENDIENTE';
        }

        // Tomar monto del precio del curso para mantener consistencia y registrar el snapshot
        $curso = Curso::findOrFail($data['curso_id']);
        $data['monto_pago'] = $curso->precio ?? 0;

        // Normalizar formato de fecha para MySQL si viene proporcionada (p. ej. ISO con Z)
        if (!empty($data['fecha_pago'])) {
            try {
                $data['fecha_pago'] = Carbon::parse($data['fecha_pago'])
                    ->setTimezone(config('app.timezone'))
                    ->toDateTimeString();
            } catch (\Exception $e) {
                // Si no se puede parsear, nulificar para evitar error SQL
                $data['fecha_pago'] = null;
            }
        }

        // Validar si ya existe la inscripción activa o pendiente para evitar duplicados
        $exists = Inscripcion::where('usuario_id', $data['usuario_id'])
            ->where('curso_id', $data['curso_id'])
            ->whereIn('estado', ['PENDIENTE', 'ACTIVO'])
            ->exists();

        if ($exists) {
            return response()->json([
                'message' => 'El estudiante ya está inscrito en este curso o tiene una solicitud pendiente.'
            ], 422);
        }

        $inscripcion = Inscripcion::create($data);

        AuditoriaService::log(
            auth('api')->id(),
            'INSCRIBIR_ESTUDIANTE',
            'Inscripcion',
            $inscripcion->id,
            "Inscripción creada: usuario_id={$inscripcion->usuario_id} en curso_id={$inscripcion->curso_id} — estado: {$inscripcion->estado}",
            null,
            $inscripcion->toArray()
        );

        return response()->json($inscripcion, 201);
    }

    public function show($id)
    {
        return response()->json(Inscripcion::with(['usuario', 'curso'])->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $inscripcion = Inscripcion::findOrFail($id);
        $anterior = $inscripcion->toArray();

        $allowedFields = [
            'usuario_id',
            'curso_id',
            'estado',
            'estado_pago',
            'monto_pago',
            'metodo_pago',
            'fecha_pago',
            'comprobante_pago_url',
            'porcentaje_progreso',
        ];

        $data = $request->only($allowedFields);

        if (!empty($data['fecha_pago'])) {
            try {
                $data['fecha_pago'] = Carbon::parse($data['fecha_pago'])
                    ->setTimezone(config('app.timezone'))
                    ->toDateTimeString();
            } catch (\Exception $e) {
                $data['fecha_pago'] = null;
            }
        }

        $inscripcion->fill($data);
        $inscripcion->save();

        AuditoriaService::log(
            auth('api')->id(),
            'ACTUALIZAR_INSCRIPCION',
            'Inscripcion',
            $inscripcion->id,
            "Inscripción actualizada: usuario_id={$inscripcion->usuario_id} en curso_id={$inscripcion->curso_id}",
            $anterior,
            $inscripcion->toArray()
        );

        return response()->json($inscripcion->fresh());
    }

    public function destroy($id)
    {
        $inscripcion = Inscripcion::findOrFail($id);

        AuditoriaService::log(
            auth('api')->id(),
            'ELIMINAR_INSCRIPCION',
            'Inscripcion',
            $inscripcion->id,
            "Inscripción eliminada: usuario_id={$inscripcion->usuario_id} de curso_id={$inscripcion->curso_id}",
            $inscripcion->toArray()
        );

        $inscripcion->delete();
        return response()->json(['message' => 'Inscripción eliminada']);
    }
}
