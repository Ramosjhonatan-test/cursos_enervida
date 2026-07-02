<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Pregunta extends Model
{
    
    protected $table = 'preguntas';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function respuestas()
    {
        return $this->hasMany(Respuesta::class, 'pregunta_id');
    }
}
