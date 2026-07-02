<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('inscripciones', function (Blueprint $table) {

        $table->id();
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        $table->string('estado')->default('PENDIENTE');
        $table->decimal('porcentaje_progreso', 5, 2)->default(0);
        $table->timestamp('fecha_inscripcion')->useCurrent();
        $table->timestamp('fecha_completado')->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('inscripciones');
    }
};
