<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('tokens_recuperacion', function (Blueprint $table) {
            // Añadir columna 'tipo' después de 'token'
            $table->string('tipo')->default('RESET_PASSWORD')->after('token');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tokens_recuperacion', function (Blueprint $table) {
            $table->dropColumn('tipo');
        });
    }
};
