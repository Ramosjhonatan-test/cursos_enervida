<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('evaluaciones', function (Blueprint $table) {

        $table->id();
        $table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        $table->string('titulo');
        $table->text('descripcion')->nullable();
        $table->decimal('nota_aprobacion', 5, 2);
        $table->integer('tiempo_limite')->nullable();
        $table->integer('intentos_permitidos')->default(1);
        $table->timestamp('fecha_creacion')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('evaluaciones');
    }
};
