<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DispositivoUsuario extends Model
{
    protected $table = 'dispositivos_usuario';
    public $timestamps = false;
    protected $guarded = [];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }
}
