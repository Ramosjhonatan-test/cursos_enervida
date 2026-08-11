<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Usuario extends Authenticatable implements JWTSubject
{
    protected $table = 'usuarios';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    // JWT Subject methods
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    public function rol()
    {
        return $this->belongsTo(Rol::class, 'rol_id');
    }

    // Inscripciones del usuario
    public function inscripciones(): HasMany
    {
        return $this->hasMany(Inscripcion::class, 'usuario_id');
    }

    // Certificados emitidos al usuario
    public function certificados(): HasMany
    {
        return $this->hasMany(Certificado::class, 'usuario_id');
    }

    // Intentos de evaluación del usuario
    public function intentos_evaluacion(): HasMany
    {
        return $this->hasMany(IntentoEvaluacion::class, 'usuario_id');
    }

    // Dispositivos vinculados al usuario
    public function dispositivos(): HasMany
    {
        return $this->hasMany(DispositivoUsuario::class, 'usuario_id')->orderBy('ultimo_acceso', 'desc');
    }

    // Logs de auditoría del usuario
    public function auditoria_logs(): HasMany
    {
        return $this->hasMany(AuditoriaLog::class, 'usuario_id')->orderBy('id', 'desc');
    }

    public function isAdmin(): bool
    {
        return strtolower($this->rol?->nombre ?? '') === 'admin';
    }

    public function isInstructor(): bool
    {
        return strtolower($this->rol?->nombre ?? '') === 'instructor';
    }

    public function hasAdminModule(string $moduleId): bool
    {
        if ($this->isAdmin()) {
            return true;
        }

        $descripcion = $this->rol?->descripcion;
        if (!$descripcion || !str_starts_with($descripcion, '{')) {
            return false;
        }

        try {
            $data = json_decode($descripcion, true, 512, JSON_THROW_ON_ERROR);
            $permisos = array_map('strtoupper', is_array($data['permisos'] ?? []) ? $data['permisos'] : []);
            return in_array(strtoupper($moduleId), $permisos, true);
        } catch (\JsonException $e) {
            return false;
        }
    }
}
