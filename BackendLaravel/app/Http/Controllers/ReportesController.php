<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Curso;
use App\Models\Usuario;
use App\Models\Inscripcion;
use App\Models\Certificado;
use App\Models\IntentoEvaluacion;
use App\Models\Categoria;
use Carbon\Carbon;

class ReportesController extends Controller
{
    public function getDashboardStats()
    {
        $totalCursos = Curso::count();
        $totalEstudiantes = Usuario::whereHas('rol', function($q) {
            $q->where('nombre', 'estudiante');
        })->count();
        $totalInscripciones = Inscripcion::count();
        $totalVentas = Curso::sum('precio');
        $pendingInscriptions = Inscripcion::where('estado', 'PENDIENTE')->count();

        $trend = $this->getTrendData();
        $activities = $this->getRecentActivities();

        return response()->json([
            'totalCursos' => $totalCursos,
            'totalEstudiantes' => $totalEstudiantes,
            'totalInscripciones' => $totalInscripciones,
            'totalVentas' => $totalVentas ?: 0,
            'trend' => $trend,
            'activities' => $activities,
            'pendingInscriptions' => $pendingInscriptions
        ]);
    }

    private function getTrendData()
    {
        $sixMonthsAgo = Carbon::now()->subMonths(6);

        $inscripciones = Inscripcion::where('fecha_inscripcion', '>=', $sixMonthsAgo)->get();

        $months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
        $trend = [];

        for ($i = 0; $i < 6; $i++) {
            $date = Carbon::now()->subMonths(5 - $i);
            $monthName = $months[$date->month - 1];
            
            $count = $inscripciones->filter(function ($ins) use ($date) {
                $insDate = Carbon::parse($ins->fecha_inscripcion);
                return $insDate->month === $date->month && $insDate->year === $date->year;
            })->count();

            $trend[] = [
                'month' => $monthName,
                'count' => $count
            ];
        }

        return $trend;
    }

    private function getRecentActivities()
    {
        $lastInscripciones = Inscripcion::with(['usuario', 'curso'])
            ->orderBy('fecha_inscripcion', 'desc')
            ->take(5)
            ->get();

        $lastUsuarios = Usuario::with('rol')
            ->orderBy('fecha_creacion', 'desc')
            ->take(5)
            ->get();

        $lastCursos = Curso::orderBy('fecha_creacion', 'desc')
            ->take(3)
            ->get();

        $lastCertificados = Certificado::with(['usuario', 'curso'])
            ->orderBy('fecha_emision', 'desc')
            ->take(3)
            ->get();

        $lastIntentos = IntentoEvaluacion::with(['usuario', 'evaluacion.curso'])
            ->where('aprobado', true)
            ->orderBy('fecha_fin', 'desc')
            ->take(3)
            ->get();

        $activities = [];

        foreach ($lastInscripciones as $ins) {
            if ($ins->usuario && $ins->curso) {
                $activities[] = [
                    'type' => 'INSCRIPCION',
                    'title' => 'Nueva Inscripción',
                    'detail' => "{$ins->usuario->nombres} se inscribió en {$ins->curso->titulo}",
                    'time' => $ins->fecha_inscripcion,
                    'icon' => 'person_add',
                    'route' => 'admin-solicitudes'
                ];
            }
        }

        foreach ($lastUsuarios as $user) {
            $rolNombre = $user->rol ? $user->rol->nombre : 'Usuario';
            $activities[] = [
                'type' => 'REGISTRO',
                'title' => 'Nuevo Usuario',
                'detail' => "{$user->nombres} {$user->apellidos} se unió como {$rolNombre}",
                'time' => $user->fecha_creacion,
                'icon' => 'how_to_reg',
                'route' => 'admin-usuarios'
            ];
        }

        foreach ($lastCursos as $curso) {
            $activities[] = [
                'type' => 'CURSO_NUEVO',
                'title' => 'Nuevo Curso',
                'detail' => "Se publicó el curso: {$curso->titulo}",
                'time' => $curso->fecha_creacion,
                'icon' => 'library_add',
                'route' => 'admin-cursos'
            ];
        }

        foreach ($lastCertificados as $cert) {
            if ($cert->usuario && $cert->curso) {
                $activities[] = [
                    'type' => 'CERTIFICADO',
                    'title' => 'Certificado Emitido',
                    'detail' => "{$cert->usuario->nombres} completó {$cert->curso->titulo}",
                    'time' => $cert->fecha_emision,
                    'icon' => 'workspace_premium',
                    'route' => 'admin-certificados'
                ];
            }
        }

        foreach ($lastIntentos as $intento) {
            if ($intento->usuario && $intento->evaluacion) {
                $cursoTitulo = $intento->evaluacion->curso ? $intento->evaluacion->curso->titulo : 'Curso';
                $activities[] = [
                    'type' => 'EVALUACION',
                    'title' => 'Evaluación Aprobada',
                    'detail' => "{$intento->usuario->nombres} aprobó {$intento->evaluacion->titulo} de {$cursoTitulo}",
                    'time' => $intento->fecha_fin,
                    'icon' => 'task_alt',
                    'route' => 'admin-evaluaciones'
                ];
            }
        }

        // Ordenar por tiempo descendente
        usort($activities, function ($a, $b) {
            return Carbon::parse($b['time'])->timestamp <=> Carbon::parse($a['time'])->timestamp;
        });

        return array_slice($activities, 0, 10);
    }

    public function getEnrollmentsByCourse()
    {
        $cursos = Curso::withCount('inscripciones')
            ->orderBy('inscripciones_count', 'desc')
            ->take(5)
            ->get();

        return response()->json($cursos->map(function ($curso) {
            return [
                'titulo' => $curso->titulo,
                'inscripciones' => $curso->inscripciones_count
            ];
        }));
    }

    public function getInscriptionsByStatus()
    {
        $estados = ['PENDIENTE', 'APROBADO', 'RECHAZADO', 'COMPLETADO'];
        $data = [];

        foreach ($estados as $estado) {
            $data[] = [
                'estado' => $estado,
                'count' => Inscripcion::where('estado', $estado)->count()
            ];
        }

        return response()->json($data);
    }

    public function getUsersByMonth()
    {
        $sixMonthsAgo = Carbon::now()->subMonths(6);
        $usuarios = Usuario::where('fecha_creacion', '>=', $sixMonthsAgo)->get();

        $months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
        $data = [];

        for ($i = 0; $i < 6; $i++) {
            $date = Carbon::now()->subMonths(5 - $i);
            
            $count = $usuarios->filter(function ($u) use ($date) {
                $uDate = Carbon::parse($u->fecha_creacion);
                return $uDate->month === $date->month && $uDate->year === $date->year;
            })->count();

            $data[] = [
                'month' => $months[$date->month - 1],
                'count' => $count
            ];
        }

        return response()->json($data);
    }

    public function getCoursesByCategory()
    {
        $categorias = Categoria::withCount('cursos')
            ->orderBy('cursos_count', 'desc')
            ->take(8)
            ->get();

        return response()->json($categorias->map(function ($cat) {
            return [
                'nombre' => $cat->nombre,
                'count' => $cat->cursos_count
            ];
        }));
    }

    public function getCertificatesByMonth()
    {
        $sixMonthsAgo = Carbon::now()->subMonths(6);
        $certs = Certificado::where('fecha_emision', '>=', $sixMonthsAgo)->get();

        $months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
        $data = [];

        for ($i = 0; $i < 6; $i++) {
            $date = Carbon::now()->subMonths(5 - $i);
            
            $count = $certs->filter(function ($c) use ($date) {
                $cDate = Carbon::parse($c->fecha_emision);
                return $cDate->month === $date->month && $cDate->year === $date->year;
            })->count();

            $data[] = [
                'month' => $months[$date->month - 1],
                'count' => $count
            ];
        }

        return response()->json($data);
    }

    public function getEvaluationResults()
    {
        $aprobados = IntentoEvaluacion::where('aprobado', true)->count();
        $reprobados = IntentoEvaluacion::where('aprobado', false)->count();

        return response()->json([
            'aprobados' => $aprobados,
            'reprobados' => $reprobados
        ]);
    }
}
