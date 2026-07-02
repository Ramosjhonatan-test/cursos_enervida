<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('tokens_recuperacion', function (Blueprint $table) {

        $table->id();
        $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        $table->string('token')->unique();
        $table->timestamp('expira_en');
        $table->boolean('usado')->default(false);
        $table->timestamp('fecha_creacion')->useCurrent();
            });
    }

    public function down()
    {
        Schema::dropIfExists('tokens_recuperacion');
    }
};
