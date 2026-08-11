<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next, ?string $moduleId = null, ...$additionalModuleIds)
    {
        $user = auth('api')->user();

        if (!$user || !$user->rol) {
            return response()->json([
                'error' => 'NO_AUTORIZADO',
                'message' => 'Acceso denegado. Se requieren privilegios de administrador.'
            ], 403);
        }

        $rolNombre = strtolower($user->rol->nombre);

        if ($rolNombre === 'admin') {
            return $next($request);
        }

        $moduleIds = [];
        if ($moduleId) {
            $moduleIds[] = $moduleId;
        }
        foreach ($additionalModuleIds as $extra) {
            if ($extra !== null && trim($extra) !== '') {
                $moduleIds[] = $extra;
            }
        }

        if (empty($moduleIds)) {
            return response()->json([
                'error' => 'NO_AUTORIZADO',
                'message' => 'Acceso denegado. Solo administradores centrales pueden ejecutar esta acción.'
            ], 403);
        }

        $descripcion = $user->rol->descripcion;
        $permisos = [];

        if ($descripcion && str_starts_with($descripcion, '{')) {
            try {
                $data = json_decode($descripcion, true, 512, JSON_THROW_ON_ERROR);
                $permisos = is_array($data['permisos'] ?? null) ? $data['permisos'] : [];
            } catch (\JsonException $e) {
                $permisos = [];
            }
        }

        $allowedModules = array_map('strtoupper', array_map('trim', $permisos));
        $requestedModules = array_map('trim', array_map('strtoupper', $moduleIds));

        foreach ($requestedModules as $requested) {
            if (in_array($requested, $allowedModules, true)) {
                return $next($request);
            }
        }

        return response()->json([
            'error' => 'NO_AUTORIZADO',
            'message' => 'Acceso denegado. No tienes permiso para este módulo.'
        ], 403);
    }
}
