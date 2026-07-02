<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('auditoria_logs', function (Blueprint $table) {

        $table->id();
        $table->foreignId('usuario_id')->nullable()->constrained('usuarios')->cascadeOnDelete();
        $table->string('accion');
        $table->string('entidad');
        $table->integer('entidad_id')->nullable();
        $table->text('descripcion')->nullable();
        $table->json('valores_anteriores')->nullable();
        $table->json('valores_nuevos')->nullable();
        $table->string('direccion_ip')->nullable();
        $table->string('user_agent')->nullable();
        $table->string('metodo_request')->nullable();
        $table->string('endpoint')->nullable();
        $table->timestamp('fecha_creacion')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('auditoria_logs');
    }
};
