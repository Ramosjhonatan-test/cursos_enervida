<?php

namespace App\Services;

use App\Models\AuditoriaLog;
use App\Models\DispositivoUsuario;
use Illuminate\Http\Request;
use Jenssegers\Agent\Agent;

class AuditoriaService
{
    /**
     * Registra una entrada en el log de auditoría.
     */
    public static function log(
        ?int $usuarioId,
        string $accion,
        string $entidad = 'Sistema',
        ?int $entidadId = null,
        ?string $descripcion = null,
        mixed $valoresAnteriores = null,
        mixed $valoresNuevos = null,
        ?Request $request = null
    ): void {
        try {
            $req = $request ?? request();

            AuditoriaLog::create([
                'usuario_id'        => $usuarioId,
                'accion'            => $accion,
                'entidad'           => $entidad,
                'entidad_id'        => $entidadId,
                'descripcion'       => $descripcion,
                'valores_anteriores'=> $valoresAnteriores ? json_encode($valoresAnteriores) : null,
                'valores_nuevos'    => $valoresNuevos    ? json_encode($valoresNuevos)    : null,
                'direccion_ip'      => $req->ip(),
                'user_agent'        => $req->header('User-Agent'),
                'metodo_request'    => $req->method(),
                'endpoint'          => $req->path(),
            ]);
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::warning('AuditoriaService::log error: ' . $e->getMessage());
        }
    }

    /**
     * Registra o actualiza el dispositivo del usuario al hacer login.
     * Usa el User-Agent para extraer OS y navegador sin librerías externas.
     */
    public static function registrarDispositivo(int $usuarioId, Request $request): void
    {
        try {
            $userAgent = $request->header('User-Agent', '');
            $ip        = $request->ip();

            // Detectar Sistema Operativo
            $os = 'Desconocido';
            if (str_contains($userAgent, 'Windows NT 10')) $os = 'Windows 10/11';
            elseif (str_contains($userAgent, 'Windows NT 6.3')) $os = 'Windows 8.1';
            elseif (str_contains($userAgent, 'Windows NT 6.1')) $os = 'Windows 7';
            elseif (str_contains($userAgent, 'Windows'))  $os = 'Windows';
            elseif (str_contains($userAgent, 'Android'))  $os = 'Android';
            elseif (str_contains($userAgent, 'iPhone') || str_contains($userAgent, 'iPad')) $os = 'iOS';
            elseif (str_contains($userAgent, 'Mac OS'))   $os = 'macOS';
            elseif (str_contains($userAgent, 'Linux'))    $os = 'Linux';

            // Detectar Navegador
            $browser = 'Desconocido';
            if (str_contains($userAgent, 'Edg/'))        $browser = 'Microsoft Edge';
            elseif (str_contains($userAgent, 'OPR/') || str_contains($userAgent, 'Opera')) $browser = 'Opera';
            elseif (str_contains($userAgent, 'Chrome'))  $browser = 'Chrome';
            elseif (str_contains($userAgent, 'Firefox')) $browser = 'Firefox';
            elseif (str_contains($userAgent, 'Safari'))  $browser = 'Safari';

            // Detectar nombre del dispositivo
            $nombre = 'Computadora';
            if (str_contains($userAgent, 'Mobile') || str_contains($userAgent, 'Android')) $nombre = 'Móvil';
            elseif (str_contains($userAgent, 'iPad') || str_contains($userAgent, 'Tablet')) $nombre = 'Tablet';

            // Fingerprint básico: combinación de IP + User-Agent hash
            $fingerprint = md5($ip . $userAgent);

            // Desactivar dispositivos activos anteriores y crear/actualizar el actual
            DispositivoUsuario::where('usuario_id', $usuarioId)
                ->where('activo', true)
                ->update(['activo' => false]);

            // Reusar el dispositivo si el fingerprint coincide, si no, crear uno nuevo
            $dispositivo = DispositivoUsuario::where('usuario_id', $usuarioId)
                ->where('fingerprint', $fingerprint)
                ->first();

            if ($dispositivo) {
                $dispositivo->update([
                    'activo'        => true,
                    'ultimo_acceso' => now(),
                    'direccion_ip'  => $ip,
                ]);
            } else {
                DispositivoUsuario::create([
                    'usuario_id'        => $usuarioId,
                    'nombre_dispositivo'=> $nombre,
                    'sistema_operativo' => $os,
                    'navegador'         => $browser,
                    'fingerprint'       => $fingerprint,
                    'direccion_ip'      => $ip,
                    'user_agent'        => $userAgent,
                    'activo'            => true,
                    'ultimo_acceso'     => now(),
                ]);
            }
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::warning('AuditoriaService::registrarDispositivo error: ' . $e->getMessage());
        }
    }
}
