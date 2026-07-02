<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Curso extends Model
{
    
    protected $table = 'cursos';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function categoria()
    {
        return $this->belongsTo(Categoria::class, 'categoria_id');
    }

    public function instructor()
    {
        return $this->belongsTo(Usuario::class, 'instructor_id');
    }

    public function modulos()
    {
        return $this->hasMany(Modulo::class, 'curso_id');
    }

    public function plantilla_certificado()
    {
        return $this->hasOne(CertificadoPlantilla::class, 'curso_id');
    }

    public function inscripciones()
    {
        return $this->hasMany(Inscripcion::class, 'curso_id');
    }

    public function evaluaciones()
    {
        return $this->hasMany(Evaluacion::class, 'curso_id');
    }
}
