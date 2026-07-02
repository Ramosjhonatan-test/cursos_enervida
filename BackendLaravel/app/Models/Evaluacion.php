<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Evaluacion extends Model
{
    
    protected $table = 'evaluaciones';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function curso()
    {
        return $this->belongsTo(Curso::class, 'curso_id');
    }

    public function preguntas()
    {
        return $this->hasMany(Pregunta::class, 'evaluacion_id');
    }
}
