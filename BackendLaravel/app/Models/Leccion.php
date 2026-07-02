<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Leccion extends Model
{
    
    protected $table = 'lecciones';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function modulo()
    {
        return $this->belongsTo(Modulo::class, 'modulo_id');
    }
}
