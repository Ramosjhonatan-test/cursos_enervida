<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('intentos_evaluacion', function (Blueprint $table) {

        $table->id();
        $table->foreignId('evaluacion_id')->constrained('evaluaciones');
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->decimal('nota', 5, 2)->nullable();
        $table->timestamp('fecha_inicio')->useCurrent();
        $table->timestamp('fecha_fin')->nullable();
        $table->boolean('aprobado')->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('intentos_evaluacion');
    }
};
