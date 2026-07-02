<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Inscripcion extends Model
{
    protected $table = 'inscripciones';
    public $timestamps = false;
    protected $guarded = [];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }

    public function curso()
    {
        return $this->belongsTo(Curso::class, 'curso_id');
    }
}
