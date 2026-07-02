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
}
