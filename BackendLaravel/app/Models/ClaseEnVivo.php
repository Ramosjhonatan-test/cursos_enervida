<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class ClaseEnVivo extends Model
{
    protected $table = 'clases_en_vivo';
    public $timestamps = false;
    protected $guarded = [];
    protected $appends = ['url_clase'];
    protected $casts = [
        'fecha_inicio' => 'datetime',
        'fecha_fin' => 'datetime',
    ];

    public function curso()
    {
        return $this->belongsTo(Curso::class, 'curso_id');
    }

    public function participantes()
    {
        return $this->hasMany(ParticipanteClaseEnVivo::class, 'clase_en_vivo_id');
    }

    public function getUrlClaseAttribute()
    {
        if (! $this->sala_jitsi) {
            return null;
        }

        return "https://meet.jit.si/{$this->sala_jitsi}";
    }
}
