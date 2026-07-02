<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class CertificadoPlantilla extends Model
{
    
    protected $table = 'certificado_plantillas';
    public $timestamps = false; // Manejado por Prisma originalmente
    protected $guarded = [];

    protected $casts = [
        'config' => 'array',
    ];
}
