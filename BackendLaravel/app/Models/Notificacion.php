<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Notificacion extends Model
{
    
    protected $table = 'notificaciones';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];
}
