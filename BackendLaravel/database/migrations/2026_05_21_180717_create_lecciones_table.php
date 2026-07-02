<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('lecciones', function (Blueprint $table) {

        $table->id();
        $table->foreignId('modulo_id')->constrained('modulos')->cascadeOnDelete();
        $table->string('titulo');
        $table->integer('orden_leccion');
        $table->string('tipo_contenido');
        $table->string('video_url')->nullable();
        $table->string('pdf_url')->nullable();
        $table->longText('contenido')->nullable();
        $table->integer('duracion_minutos')->nullable();
        $table->boolean('es_preview')->default(false);
        $table->timestamp('fecha_creacion')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('lecciones');
    }
};
