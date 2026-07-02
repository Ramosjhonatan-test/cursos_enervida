<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class ProgresoLeccion extends Model
{
    protected $table = 'progreso_lecciones';
    public $timestamps = false;
    protected $guarded = [];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }

    public function leccion()
    {
        return $this->belongsTo(Leccion::class, 'leccion_id');
    }
}
