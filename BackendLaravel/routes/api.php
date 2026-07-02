<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CursoController;
use App\Http\Controllers\UsuarioController;
use App\Http\Controllers\EvaluacionController;
use App\Http\Controllers\LeccionController;
use App\Http\Controllers\RolController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ModuloController;
use App\Http\Controllers\InscripcionController;
use App\Http\Controllers\ProgresoController;
use App\Http\Controllers\PreguntaController;
use App\Http\Controllers\RespuestaController;
use App\Http\Controllers\IntentoEvaluacionController;
use App\Http\Controllers\ClaseEnVivoController;
use App\Http\Controllers\NotificacionController;
use App\Http\Controllers\AuditoriaController;
use App\Http\Controllers\CertificadoController;
use App\Http\Controllers\CertificadoPlantillaController;
use App\Http\Controllers\UploadController;
use App\Http\Controllers\ReportesController;
use App\Http\Controllers\DispositivoUsuarioController;

/*
|--------------------------------------------------------------------------
| 1. Rutas Públicas (Sin Autenticación)
|--------------------------------------------------------------------------
*/

// Autenticación pública
Route::group(['prefix' => 'auth'], function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::post('google', [AuthController::class, 'googleLogin']);
    Route::post('refresh', [AuthController::class, 'refresh']);
    Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('reset-password', [AuthController::class, 'resetPassword']);
    Route::get('verify-email', [AuthController::class, 'verifyEmail']);
});

// Catálogo y validaciones públicas
Route::get('cursos/public', [CursoController::class, 'findPublished']);
Route::get('certificados/validar/{codigo}', [CertificadoController::class, 'validarCertificado']);
Route::get('roles', [RolController::class, 'index']); // Necesario para dropdowns públicos si los hubiera
Route::get('roles/{id}', [RolController::class, 'show']);
Route::get('categorias', [CategoriaController::class, 'index']); // Para filtros de catálogo públicos
Route::get('categorias/{id}', [CategoriaController::class, 'show']);

// Rutas de administración de archivos (deben ir ANTES de la wildcard pública)
Route::middleware(['auth:api', 'admin'])->group(function () {
    Route::get('uploads/admin/list', [UploadController::class, 'findAll']);
    Route::post('uploads/admin/bulk-delete', [UploadController::class, 'removeBulk']);
    Route::delete('uploads/admin/{filename}', [UploadController::class, 'remove']);
});

// Acceso público a archivos multimedia y subidos (wildcard — debe ir al final)
Route::get('uploads/{path}', [UploadController::class, 'serveWildcardFile'])->where('path', '.*');


/*
|--------------------------------------------------------------------------
| 2. Rutas Protegidas Generales (Requieren Token de Usuario)
|--------------------------------------------------------------------------
*/
Route::middleware('auth:api')->group(function () {
    // Logout
    Route::post('auth/logout', [AuthController::class, 'logout']);

    // Perfil del usuario autenticado
    Route::get('usuarios/profile', [UsuarioController::class, 'getProfile']);
    Route::patch('usuarios/profile', [UsuarioController::class, 'updateProfile']);

    // Inscripciones y solicitudes del propio estudiante
    Route::get('inscripciones/me', [InscripcionController::class, 'findMyInscripciones']);
    Route::post('inscripciones', [InscripcionController::class, 'store']); // Estudiante solicita inscripción

    // Certificados del estudiante
    Route::get('certificados/me', [CertificadoController::class, 'findMyCertificados']);
    Route::get('certificados/{id}/pdf', [CertificadoController::class, 'downloadPdf']);
    Route::get('certificados/{id}/download', [CertificadoController::class, 'downloadPdf']);

    // Progreso en lecciones (Lectura y guardado de avance)
    Route::apiResource('progreso', ProgresoController::class);

    // Intentos de examen y evaluación (Realizados por el estudiante)
    Route::apiResource('intentos-evaluacion', IntentoEvaluacionController::class);

    // Subida de archivos (Ej. fotos de perfil o tareas)
    Route::post('uploads', [UploadController::class, 'upload']);

    // Clases en Vivo (Estudiantes leen horarios)
    Route::get('clases-en-vivo', [ClaseEnVivoController::class, 'index']);
    Route::get('clases-en-vivo/{id}', [ClaseEnVivoController::class, 'show']);

    // Notificaciones (Estudiantes leen y marcan leídas sus alertas)
    Route::get('notificaciones', [NotificacionController::class, 'index']);
    Route::get('notificaciones/{id}', [NotificacionController::class, 'show']);
    Route::patch('notificaciones/{id}', [NotificacionController::class, 'update']);

    // Lectura de Cursos y Contenidos (Necesarios para el reproductor de clases)
    Route::get('cursos', [CursoController::class, 'index']);
    Route::get('cursos/{id}', [CursoController::class, 'show']);
    Route::get('modulos', [ModuloController::class, 'index']);
    Route::get('modulos/{id}', [ModuloController::class, 'show']);
    Route::get('lecciones', [LeccionController::class, 'index']);
    Route::get('lecciones/{id}', [LeccionController::class, 'show']);
    Route::get('evaluaciones', [EvaluacionController::class, 'index']);
    Route::get('evaluaciones/{id}', [EvaluacionController::class, 'show']);
    Route::get('preguntas', [PreguntaController::class, 'index']);
    Route::get('preguntas/{id}', [PreguntaController::class, 'show']);
    Route::get('respuestas', [RespuestaController::class, 'index']);
    Route::get('respuestas/{id}', [RespuestaController::class, 'show']);

    // Preview de plantilla de certificado (accesible con ?token= para iframes)
    Route::get('certificados/preview/{plantillaId}', [CertificadoPlantillaController::class, 'preview']);
});


/*
|--------------------------------------------------------------------------
| 3. Rutas de Administrador (Requieren Token de Admin)
|--------------------------------------------------------------------------
*/
Route::middleware(['auth:api', 'admin'])->group(function () {
    // Cuentas de usuario
    Route::get('usuarios/rol/{nombre}', [UsuarioController::class, 'findByRole']);
    Route::apiResource('usuarios', UsuarioController::class);

    // Gestión completa de inscripciones (Aprobar, rechazar, eliminar solicitudes)
    Route::apiResource('inscripciones', InscripcionController::class)->except(['store']);
    
    // Gestión completa de clases en vivo (Programar, editar, eliminar)
    Route::post('clases-en-vivo', [ClaseEnVivoController::class, 'store']);
    Route::put('clases-en-vivo/{id}', [ClaseEnVivoController::class, 'update']);
    Route::patch('clases-en-vivo/{id}', [ClaseEnVivoController::class, 'update']);
    Route::delete('clases-en-vivo/{id}', [ClaseEnVivoController::class, 'destroy']);

    // Gestión de notificaciones administrativas
    Route::post('notificaciones', [NotificacionController::class, 'store']);
    Route::delete('notificaciones/{id}', [NotificacionController::class, 'destroy']);

    // Gestión completa de roles y categorías
    Route::apiResource('roles', RolController::class)->except(['index', 'show']);
    Route::apiResource('categorias', CategoriaController::class)->except(['index', 'show']);

    // Creación y modificación de Cursos y Contenidos
    Route::post('cursos', [CursoController::class, 'store']);
    Route::put('cursos/{id}', [CursoController::class, 'update']);
    Route::patch('cursos/{id}', [CursoController::class, 'update']);
    Route::delete('cursos/{id}', [CursoController::class, 'destroy']);

    Route::apiResource('modulos', ModuloController::class)->except(['index', 'show']);
    Route::apiResource('lecciones', LeccionController::class)->except(['index', 'show']);
    Route::apiResource('evaluaciones', EvaluacionController::class)->except(['index', 'show']);
    Route::apiResource('preguntas', PreguntaController::class)->except(['index', 'show']);
    Route::apiResource('respuestas', RespuestaController::class)->except(['index', 'show']);

    // Plantillas de certificado
    Route::apiResource('certificados', CertificadoController::class)->only(['index', 'show', 'store']);
    Route::get('certificado-plantillas/curso/{cursoId}', [CertificadoPlantillaController::class, 'showByCurso']);
    Route::apiResource('certificado-plantillas', CertificadoPlantillaController::class);

    // Bitácora de Auditoría
    Route::delete('auditoria/all/clear', [AuditoriaController::class, 'clear']);
    Route::apiResource('auditoria', AuditoriaController::class);

    // Reportes analíticos del sistema
    Route::get('reportes/dashboard', [ReportesController::class, 'getDashboardStats']);
    Route::get('reportes/inscripciones-por-curso', [ReportesController::class, 'getEnrollmentsByCourse']);
    Route::get('reportes/inscripciones-por-estado', [ReportesController::class, 'getInscriptionsByStatus']);
    Route::get('reportes/usuarios-por-mes', [ReportesController::class, 'getUsersByMonth']);
    Route::get('reportes/cursos-por-categoria', [ReportesController::class, 'getCoursesByCategory']);
    Route::get('reportes/certificados-por-mes', [ReportesController::class, 'getCertificatesByMonth']);
    Route::get('reportes/evaluaciones-resultados', [ReportesController::class, 'getEvaluationResults']);

    // Gestión de dispositivos de usuario (Ver y liberar cuentas)
    Route::patch('dispositivos-usuario/liberate/{userId}', [DispositivoUsuarioController::class, 'liberate']);
    Route::apiResource('dispositivos-usuario', DispositivoUsuarioController::class);

});
