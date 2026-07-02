<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('certificado_plantillas', function (Blueprint $table) {

        $table->id();
        $table->foreignId('curso_id')->unique()->constrained('cursos')->cascadeOnDelete();
        $table->string('nombre');
        $table->string('background_url');
        $table->json('config');
        $table->timestamp('fecha_creacion')->useCurrent();
        $table->timestamp('fecha_actualizacion')->useCurrentOnUpdate()->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('certificado_plantillas');
    }
};
