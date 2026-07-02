<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class ParticipanteClaseEnVivo extends Model
{
    
    protected $table = 'participantes_clase_en_vivo';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];
}
