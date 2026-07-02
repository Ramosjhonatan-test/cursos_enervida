<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('certificados', function (Blueprint $table) {

        $table->id();
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        $table->string('codigo_certificado')->unique();
        $table->string('pdf_url');
        $table->timestamp('fecha_emision')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('certificados');
    }
};
