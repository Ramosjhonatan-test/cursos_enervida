<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('usuarios', function (Blueprint $table) {

        $table->id();
        $table->foreignId('rol_id')->constrained('roles');
        $table->string('nombres');
        $table->string('apellidos');
        $table->string('correo')->unique();
        $table->string('contrasena_hash')->nullable();
        $table->string('telefono')->nullable();
        $table->string('imagen_perfil')->nullable();
        $table->string('estado')->default('ACTIVO');
        $table->boolean('correo_verificado')->default(false);
        $table->timestamp('ultimo_login')->nullable();
        $table->timestamp('fecha_creacion')->useCurrent();
        $table->timestamp('fecha_actualizacion')->useCurrentOnUpdate()->nullable();
        $table->string('refresh_token')->nullable();
        $table->string('ci')->unique()->nullable();
        $table->string('google_id')->unique()->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('usuarios');
    }
};
