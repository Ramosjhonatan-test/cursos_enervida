<?php

$migrations = [
    'roles' => "
        \$table->id();
        \$table->string('nombre')->unique();
        \$table->text('descripcion')->nullable();
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'usuarios' => "
        \$table->id();
        \$table->foreignId('rol_id')->constrained('roles');
        \$table->string('nombres');
        \$table->string('apellidos');
        \$table->string('correo')->unique();
        \$table->string('contrasena_hash')->nullable();
        \$table->string('telefono')->nullable();
        \$table->string('imagen_perfil')->nullable();
        \$table->string('estado')->default('ACTIVO');
        \$table->boolean('correo_verificado')->default(false);
        \$table->timestamp('ultimo_login')->nullable();
        \$table->timestamp('fecha_creacion')->useCurrent();
        \$table->timestamp('fecha_actualizacion')->useCurrentOnUpdate()->nullable();
        \$table->string('refresh_token')->nullable();
        \$table->string('ci')->unique()->nullable();
        \$table->string('google_id')->unique()->nullable();
    ",
    'dispositivos_usuario' => "
        \$table->id();
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->string('nombre_dispositivo')->nullable();
        \$table->string('sistema_operativo')->nullable();
        \$table->string('navegador')->nullable();
        \$table->string('fingerprint')->nullable();
        \$table->string('direccion_ip')->nullable();
        \$table->boolean('activo')->default(true);
        \$table->timestamp('ultimo_acceso')->nullable();
        \$table->timestamp('fecha_creacion')->useCurrent();
        \$table->string('user_agent')->nullable();
    ",
    'categorias' => "
        \$table->id();
        \$table->string('nombre')->unique();
        \$table->text('descripcion')->nullable();
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'cursos' => "
        \$table->id();
        \$table->foreignId('categoria_id')->constrained('categorias');
        \$table->foreignId('instructor_id')->constrained('usuarios');
        \$table->string('titulo');
        \$table->string('slug')->unique();
        \$table->text('descripcion_corta')->nullable();
        \$table->longText('descripcion')->nullable();
        \$table->string('miniatura_url')->nullable();
        \$table->string('nivel')->nullable();
        \$table->string('tipo_curso')->nullable();
        \$table->boolean('certificado_habilitado')->default(true);
        \$table->boolean('publicado')->default(false);
        \$table->decimal('precio', 10, 2)->nullable();
        \$table->timestamp('fecha_creacion')->useCurrent();
        \$table->timestamp('fecha_actualizacion')->useCurrentOnUpdate()->nullable();
    ",
    'certificado_plantillas' => "
        \$table->id();
        \$table->foreignId('curso_id')->unique()->constrained('cursos')->cascadeOnDelete();
        \$table->string('nombre');
        \$table->string('background_url');
        \$table->json('config');
        \$table->timestamp('fecha_creacion')->useCurrent();
        \$table->timestamp('fecha_actualizacion')->useCurrentOnUpdate()->nullable();
    ",
    'modulos' => "
        \$table->id();
        \$table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        \$table->string('titulo');
        \$table->integer('orden_modulo');
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'lecciones' => "
        \$table->id();
        \$table->foreignId('modulo_id')->constrained('modulos')->cascadeOnDelete();
        \$table->string('titulo');
        \$table->integer('orden_leccion');
        \$table->string('tipo_contenido');
        \$table->string('video_url')->nullable();
        \$table->string('pdf_url')->nullable();
        \$table->longText('contenido')->nullable();
        \$table->integer('duracion_minutos')->nullable();
        \$table->boolean('es_preview')->default(false);
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'clases_en_vivo' => "
        \$table->id();
        \$table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        \$table->string('titulo');
        \$table->text('descripcion')->nullable();
        \$table->string('sala_jitsi');
        \$table->timestamp('fecha_inicio');
        \$table->timestamp('fecha_fin')->nullable();
        \$table->foreignId('creado_por')->constrained('usuarios');
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'participantes_clase_en_vivo' => "
        \$table->id();
        \$table->foreignId('clase_en_vivo_id')->constrained('clases_en_vivo');
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->timestamp('hora_ingreso');
        \$table->timestamp('hora_salida')->nullable();
        \$table->integer('minutos_asistencia')->nullable();
    ",
    'inscripciones' => "
        \$table->id();
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        \$table->string('estado')->default('PENDIENTE');
        \$table->decimal('porcentaje_progreso', 5, 2)->default(0);
        \$table->timestamp('fecha_inscripcion')->useCurrent();
        \$table->timestamp('fecha_completado')->nullable();
    ",
    'progreso_lecciones' => "
        \$table->id();
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->foreignId('leccion_id')->constrained('lecciones');
        \$table->boolean('completado')->default(false);
        \$table->timestamp('fecha_completado')->nullable();
        \$table->integer('segundos_vistos')->default(0);
    ",
    'evaluaciones' => "
        \$table->id();
        \$table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        \$table->string('titulo');
        \$table->text('descripcion')->nullable();
        \$table->decimal('nota_aprobacion', 5, 2);
        \$table->integer('tiempo_limite')->nullable();
        \$table->integer('intentos_permitidos')->default(1);
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'preguntas' => "
        \$table->id();
        \$table->foreignId('evaluacion_id')->constrained('evaluaciones');
        \$table->text('pregunta');
        \$table->string('tipo_pregunta');
        \$table->integer('puntos')->default(1);
    ",
    'respuestas' => "
        \$table->id();
        \$table->foreignId('pregunta_id')->constrained('preguntas');
        \$table->text('respuesta');
        \$table->boolean('es_correcta')->default(false);
    ",
    'intentos_evaluacion' => "
        \$table->id();
        \$table->foreignId('evaluacion_id')->constrained('evaluaciones');
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->decimal('nota', 5, 2)->nullable();
        \$table->timestamp('fecha_inicio')->useCurrent();
        \$table->timestamp('fecha_fin')->nullable();
        \$table->boolean('aprobado')->nullable();
    ",
    'certificados' => "
        \$table->id();
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->foreignId('curso_id')->constrained('cursos')->cascadeOnDelete();
        \$table->string('codigo_certificado')->unique();
        \$table->string('pdf_url');
        \$table->timestamp('fecha_emision')->useCurrent();
    ",
    'tokens_recuperacion' => "
        \$table->id();
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->string('token')->unique();
        \$table->timestamp('expira_en');
        \$table->boolean('usado')->default(false);
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'notificaciones' => "
        \$table->id();
        \$table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
        \$table->string('titulo');
        \$table->text('mensaje');
        \$table->boolean('leido')->default(false);
        \$table->timestamp('fecha_creacion')->useCurrent();
    ",
    'auditoria_logs' => "
        \$table->id();
        \$table->foreignId('usuario_id')->nullable()->constrained('usuarios')->cascadeOnDelete();
        \$table->string('accion');
        \$table->string('entidad');
        \$table->integer('entidad_id')->nullable();
        \$table->text('descripcion')->nullable();
        \$table->json('valores_anteriores')->nullable();
        \$table->json('valores_nuevos')->nullable();
        \$table->string('direccion_ip')->nullable();
        \$table->string('user_agent')->nullable();
        \$table->string('metodo_request')->nullable();
        \$table->string('endpoint')->nullable();
        \$table->timestamp('fecha_creacion')->useCurrent();
    "
];

$models = [
    'roles' => 'Rol',
    'usuarios' => 'Usuario',
    'dispositivos_usuario' => 'DispositivoUsuario',
    'categorias' => 'Categoria',
    'cursos' => 'Curso',
    'certificado_plantillas' => 'CertificadoPlantilla',
    'modulos' => 'Modulo',
    'lecciones' => 'Leccion',
    'clases_en_vivo' => 'ClaseEnVivo',
    'participantes_clase_en_vivo' => 'ParticipanteClaseEnVivo',
    'inscripciones' => 'Inscripcion',
    'progreso_lecciones' => 'ProgresoLeccion',
    'evaluaciones' => 'Evaluacion',
    'preguntas' => 'Pregunta',
    'respuestas' => 'Respuesta',
    'intentos_evaluacion' => 'IntentoEvaluacion',
    'certificados' => 'Certificado',
    'tokens_recuperacion' => 'TokenRecuperacion',
    'notificaciones' => 'Notificacion',
    'auditoria_logs' => 'AuditoriaLog'
];

$dir = __DIR__ . '/BackendLaravel';
chdir($dir);

// 1. Delete all existing migrations except 0001_01_01_000000_create_users_table.php (if any)
$migrationFiles = glob('database/migrations/*.php');
foreach ($migrationFiles as $file) {
    if (strpos($file, 'users') === false && strpos($file, 'cache') === false && strpos($file, 'jobs') === false) {
        unlink($file);
    }
}

// Ensure the old users migration is also deleted because we are using usuarios
foreach (glob('database/migrations/*users*.php') as $file) {
    unlink($file);
}

// 2. Generate and rewrite migrations in order
$time = time();
foreach ($migrations as $table => $schema) {
    // Generate the migration file using artisan (wait 1 sec so timestamps are sorted)
    $output = shell_exec('C:\xampp\php\php.exe artisan make:migration create_'.$table.'_table');
    sleep(1);
    
    // Find the newest migration file
    $files = glob('database/migrations/*_create_'.$table.'_table.php');
    if (count($files) > 0) {
        $file = $files[0];
        $content = "<?php\n\nuse Illuminate\\Database\\Migrations\\Migration;\nuse Illuminate\\Database\\Schema\\Blueprint;\nuse Illuminate\\Support\\Facades\\Schema;\n\nreturn new class extends Migration\n{\n    public function up()\n    {\n        Schema::create('$table', function (Blueprint \$table) {\n$schema        });\n    }\n\n    public function down()\n    {\n        Schema::dropIfExists('$table');\n    }\n};\n";
        file_put_contents($file, $content);
    }
}

// 3. Rewrite Models
foreach ($models as $table => $modelName) {
    $modelFile = 'app/Models/' . $modelName . '.php';
    if (!file_exists($modelFile)) {
        shell_exec('C:\xampp\php\php.exe artisan make:model ' . $modelName);
    }
    
    $extends = $modelName === 'Usuario' ? 'use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;
class Usuario extends Authenticatable' : 'use Illuminate\Database\Eloquent\Model;
class '.$modelName.' extends Model';

    $hasApiTokens = $modelName === 'Usuario' ? 'use HasApiTokens;' : '';

    $content = "<?php\n\nnamespace App\Models;\n\n$extends\n{\n    $hasApiTokens\n    protected \$table = '$table';\n    public \$timestamps = false; // Manejado por Prisma originalmente\n    protected \$guarded = [];\n}\n";
    file_put_contents($modelFile, $content);
}

echo "Generacion completa.\n";
