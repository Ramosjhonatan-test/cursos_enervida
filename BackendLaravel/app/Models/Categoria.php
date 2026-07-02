<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Categoria extends Model
{
    
    protected $table = 'categorias';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function cursos()
    {
        return $this->hasMany(Curso::class, 'categoria_id');
    }
}
