<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Modulo extends Model
{
    
    protected $table = 'modulos';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function lecciones()
    {
        return $this->hasMany(Leccion::class, 'modulo_id');
    }
}
