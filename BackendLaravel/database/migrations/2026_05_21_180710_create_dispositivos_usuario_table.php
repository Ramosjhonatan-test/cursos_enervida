<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('dispositivos_usuario', function (Blueprint $table) {

        $table->id();
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->string('nombre_dispositivo')->nullable();
        $table->string('sistema_operativo')->nullable();
        $table->string('navegador')->nullable();
        $table->string('fingerprint')->nullable();
        $table->string('direccion_ip')->nullable();
        $table->boolean('activo')->default(true);
        $table->timestamp('ultimo_acceso')->nullable();
        $table->timestamp('fecha_creacion')->useCurrent();
        $table->string('user_agent')->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('dispositivos_usuario');
    }
};
