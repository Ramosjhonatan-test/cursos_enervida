<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('participantes_clase_en_vivo', function (Blueprint $table) {

        $table->id();
        $table->foreignId('clase_en_vivo_id')->constrained('clases_en_vivo');
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->timestamp('hora_ingreso');
        $table->timestamp('hora_salida')->nullable();
        $table->integer('minutos_asistencia')->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('participantes_clase_en_vivo');
    }
};
