<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Rol extends Model
{
    
    protected $table = 'roles';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];
}
