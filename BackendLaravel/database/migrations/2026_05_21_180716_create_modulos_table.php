<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('modulos', function (Blueprint $table) {

        $table->id();
        $table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        $table->string('titulo');
        $table->integer('orden_modulo');
        $table->timestamp('fecha_creacion')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('modulos');
    }
};
