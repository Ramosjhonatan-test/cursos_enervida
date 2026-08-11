<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('inscripciones', function (Blueprint $table) {
            $table->string('estado_pago', 50)->default('PENDIENTE')->after('estado');
            $table->decimal('monto_pago', 10, 2)->default(0)->after('estado_pago');
            $table->string('metodo_pago')->nullable()->after('monto_pago');
            $table->timestamp('fecha_pago')->nullable()->after('metodo_pago');
            $table->string('comprobante_pago_url')->nullable()->after('fecha_pago');
        });
    }

    public function down()
    {
        Schema::table('inscripciones', function (Blueprint $table) {
            $table->dropColumn(['estado_pago', 'monto_pago', 'metodo_pago', 'fecha_pago', 'comprobante_pago_url']);
        });
    }
};
