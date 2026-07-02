<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('clases_en_vivo', function (Blueprint $table) {

        $table->id();
        $table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        $table->string('titulo');
        $table->text('descripcion')->nullable();
        $table->string('sala_jitsi');
        $table->timestamp('fecha_inicio');
        $table->timestamp('fecha_fin')->nullable();
        $table->foreignId('creado_por')->constrained('usuarios');
        $table->timestamp('fecha_creacion')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('clases_en_vivo');
    }
};
