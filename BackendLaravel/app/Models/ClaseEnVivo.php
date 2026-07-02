<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class ClaseEnVivo extends Model
{
    protected $table = 'clases_en_vivo';
    public $timestamps = false;
    protected $guarded = [];

    public function curso()
    {
        return $this->belongsTo(Curso::class, 'curso_id');
    }

    public function participantes()
    {
        return $this->hasMany(ParticipanteClaseEnVivo::class, 'clase_en_vivo_id');
    }
}
