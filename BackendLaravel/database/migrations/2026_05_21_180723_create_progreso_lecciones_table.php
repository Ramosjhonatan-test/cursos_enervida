<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('progreso_lecciones', function (Blueprint $table) {

        $table->id();
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->foreignId('leccion_id')->constrained('lecciones');
        $table->boolean('completado')->default(false);
        $table->timestamp('fecha_completado')->nullable();
        $table->integer('segundos_vistos')->default(0);
            });
    }

    public function down()
    {
        Schema::dropIfExists('progreso_lecciones');
    }
};
