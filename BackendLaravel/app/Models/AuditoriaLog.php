<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class AuditoriaLog extends Model
{
    protected $table = 'auditoria_logs';
    public $timestamps = false;
    protected $guarded = [];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }
}
