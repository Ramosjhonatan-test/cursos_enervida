<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('respuestas', function (Blueprint $table) {

        $table->id();
        $table->foreignId('pregunta_id')->constrained('preguntas');
        $table->text('respuesta');
        $table->boolean('es_correcta')->default(false);
            });
    }

    public function down()
    {
        Schema::dropIfExists('respuestas');
    }
};
