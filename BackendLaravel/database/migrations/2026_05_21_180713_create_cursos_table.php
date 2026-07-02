<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cursos', function (Blueprint $table) {

        $table->id();
        $table->foreignId('categoria_id')->constrained('categorias');
        $table->foreignId('instructor_id')->constrained('usuarios');
        $table->string('titulo');
        $table->string('slug')->unique();
        $table->text('descripcion_corta')->nullable();
        $table->longText('descripcion')->nullable();
        $table->string('miniatura_url')->nullable();
        $table->string('nivel')->nullable();
        $table->string('tipo_curso')->nullable();
        $table->boolean('certificado_habilitado')->default(true);
        $table->boolean('publicado')->default(false);
        $table->decimal('precio', 10, 2)->nullable();
        $table->timestamp('fecha_creacion')->useCurrent();
        $table->timestamp('fecha_actualizacion')->useCurrentOnUpdate()->nullable();
            });
    }

    public function down()
    {
        Schema::dropIfExists('cursos');
    }
};
