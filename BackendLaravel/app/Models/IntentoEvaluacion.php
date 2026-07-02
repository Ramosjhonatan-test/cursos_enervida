<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class IntentoEvaluacion extends Model
{
    protected $table = 'intentos_evaluacion';
    public $timestamps = false;
    protected $guarded = [];

    protected $casts = [
        'respuestas_seleccionadas' => 'array',
        'aprobado' => 'boolean',
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }

    public function evaluacion()
    {
        return $this->belongsTo(Evaluacion::class, 'evaluacion_id');
    }
}
