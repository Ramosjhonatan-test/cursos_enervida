<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class TokenRecuperacion extends Model
{
    
    protected $table = 'tokens_recuperacion';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];
}
