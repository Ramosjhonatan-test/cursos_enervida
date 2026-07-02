<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('preguntas', function (Blueprint $table) {

        $table->id();
        $table->foreignId('evaluacion_id')->constrained('evaluaciones');
        $table->text('pregunta');
        $table->string('tipo_pregunta');
        $table->integer('puntos')->default(1);
            });
    }

    public function down()
    {
        Schema::dropIfExists('preguntas');
    }
};
