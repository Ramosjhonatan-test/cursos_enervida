<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Rol;
use App\Models\Usuario;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Crear Roles
        $rolAdmin = Rol::firstOrCreate(
            ['nombre' => 'admin'],
            ['descripcion' => 'Administrador del sistema']
        );

        $rolEstudiante = Rol::firstOrCreate(
            ['nombre' => 'estudiante'],
            ['descripcion' => 'Estudiante del sistema']
        );

        $this->command->info("Roles creados: admin={$rolAdmin->id}, estudiante={$rolEstudiante->id}");

        // 2. Crear Usuario Admin
        $adminUser = Usuario::updateOrCreate(
            ['correo' => 'admin@enervida.bo'],
            [
                'rol_id' => $rolAdmin->id,
                'nombres' => 'Administrador',
                'apellidos' => 'Principal',
                'correo' => 'admin@enervida.bo',
                'contrasena_hash' => Hash::make('admin123'),
                'estado' => 'ACTIVO',
                'correo_verificado' => true,
            ]
        );

        $this->command->info("Admin creado/actualizado: {$adminUser->correo} | Password: admin123");
    }
}
