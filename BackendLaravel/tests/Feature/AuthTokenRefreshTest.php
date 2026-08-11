<?php

namespace Tests\Feature;

use App\Models\Rol;
use App\Models\Usuario;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Tests\TestCase;

class AuthTokenRefreshTest extends TestCase
{
    public function test_login_refresh_and_logout_flow(): void
    {
        // Create minimal tables in in-memory sqlite to avoid running full migrations
        if (!Schema::hasTable('roles')) {
            Schema::create('roles', function (Blueprint $table) {
                $table->id();
                $table->string('nombre');
                $table->text('descripcion')->nullable();
            });
        }

        if (!Schema::hasTable('usuarios')) {
            Schema::create('usuarios', function (Blueprint $table) {
                $table->id();
                $table->foreignId('rol_id')->constrained('roles');
                $table->string('nombres');
                $table->string('apellidos');
                $table->string('correo')->unique();
                $table->string('contrasena_hash')->nullable();
                $table->string('estado')->default('ACTIVO');
                $table->boolean('correo_verificado')->default(false);
                $table->timestamp('ultimo_login')->nullable();
                $table->string('refresh_token')->nullable();
            });
        }

        if (!Schema::hasTable('auditoria_logs')) {
            Schema::create('auditoria_logs', function (Blueprint $table) {
                $table->id();
                $table->unsignedBigInteger('usuario_id')->nullable();
                $table->string('accion');
                $table->text('valores_nuevos')->nullable();
                $table->timestamp('fecha_creacion')->nullable();
            });
        }

        if (!Schema::hasTable('dispositivos_usuario')) {
            Schema::create('dispositivos_usuario', function (Blueprint $table) {
                $table->id();
                $table->unsignedBigInteger('usuario_id');
                $table->string('fingerprint')->nullable();
                $table->boolean('activo')->default(true);
                $table->timestamp('ultimo_acceso')->nullable();
            });
        }

        Rol::create([
            'nombre' => 'estudiante',
            'descripcion' => json_encode(['permisos' => []]),
        ]);

        $usuario = Usuario::create([
            'rol_id' => 1,
            'nombres' => 'Test',
            'apellidos' => 'Usuario',
            'correo' => 'test@example.com',
            'contrasena_hash' => Hash::make('secret123'),
            'estado' => 'ACTIVO',
            'correo_verificado' => false,
        ]);

        $loginResponse = $this->postJson('/api/auth/login', [
            'email' => 'test@example.com',
            'password' => 'secret123',
        ]);

        $loginResponse->assertStatus(200);
        $loginData = $loginResponse->json();

        $this->assertArrayHasKey('access_token', $loginData);
        $this->assertArrayHasKey('refresh_token', $loginData);
        $this->assertArrayHasKey('user', $loginData);
        $this->assertEquals($usuario->id, $loginData['user']['id']);

        $refreshResponse = $this->postJson('/api/auth/refresh', [
            'userId' => $usuario->id,
            'refreshToken' => $loginData['refresh_token'],
        ]);

        $refreshResponse->assertStatus(200);
        $refreshData = $refreshResponse->json();

        $this->assertArrayHasKey('access_token', $refreshData);
        $this->assertArrayHasKey('refresh_token', $refreshData);
        $this->assertNotEquals($loginData['access_token'], $refreshData['access_token']);
        $this->assertNotEquals($loginData['refresh_token'], $refreshData['refresh_token']);

        $this->withHeaders([
            'Authorization' => 'Bearer ' . $refreshData['access_token'],
        ])->postJson('/api/auth/logout')
          ->assertStatus(200)
          ->assertJson(['message' => 'Successfully logged out']);

        $this->postJson('/api/auth/refresh', [
            'userId' => $usuario->id,
            'refreshToken' => $refreshData['refresh_token'],
        ])->assertStatus(401);
    }
}
