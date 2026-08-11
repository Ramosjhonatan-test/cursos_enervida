<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Curso extends Model
{
    protected $table = 'cursos';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    public function obtenerPrefijoCertificado(): string
    {
        $slug = trim((string) ($this->slug ?? ''));
        if ($slug === '') {
            return 'CUR';
        }

        $palabras = array_filter(
            preg_split('/[^a-z0-9]+/i', $slug),
            fn($p) => !in_array(strtolower($p), ['de', 'con', 'y', 'a', 'la', 'el', 'en', 'para', 'del', 'los', 'las', 'por', 'al', 'lo'])
        );

        $palabras = array_values($palabras);
        if (count($palabras) >= 3) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1) . substr($palabras[2], 0, 1));
        }
        if (count($palabras) === 2) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1));
        }
        if (count($palabras) === 1) {
            return strtoupper(substr($palabras[0], 0, 3));
        }

        return strtoupper(substr($slug, 0, 3));
    }

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
