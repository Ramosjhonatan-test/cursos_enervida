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
    public function getDetailedReport(Request $request)
    {
        $filters = $request->validate([
            'type' => 'required|in:inscripciones,usuarios,cursos,certificados,evaluaciones',
            'from' => 'nullable|date', 'to' => 'nullable|date', 'status' => 'nullable|string|max:50',
            'payment_status' => 'nullable|string|max:50', 'course_id' => 'nullable|integer|exists:cursos,id',
            'search' => 'nullable|string|max:100',
        ]);
        $type = $filters['type'];
        $search = trim($filters['search'] ?? '');

        if ($type === 'inscripciones') {
            $query = Inscripcion::with(['usuario', 'curso'])->orderByDesc('fecha_inscripcion');
            $this->applyDateRange($query, 'fecha_inscripcion', $filters);
            $query->when($filters['status'] ?? null, fn ($q, $v) => $q->where('estado', $v));
            $query->when($filters['payment_status'] ?? null, fn ($q, $v) => $q->where('estado_pago', $v));
            $query->when($filters['course_id'] ?? null, fn ($q, $v) => $q->where('curso_id', $v));
            $query->when($search !== '', fn ($q) => $q->where(function ($inner) use ($search) {
                $inner->whereHas('usuario', fn ($u) => $u->where('nombres', 'like', "%{$search}%")->orWhere('apellidos', 'like', "%{$search}%")->orWhere('correo', 'like', "%{$search}%"))
                    ->orWhereHas('curso', fn ($c) => $c->where('titulo', 'like', "%{$search}%"));
            }));
            $rows = $query->get()->map(fn ($i) => [
                'id' => $i->id, 'fecha' => $i->fecha_inscripcion,
                'estudiante' => trim(($i->usuario->nombres ?? '') . ' ' . ($i->usuario->apellidos ?? '')),
                'correo' => $i->usuario->correo ?? '', 'curso' => $i->curso->titulo ?? '', 'estado' => $i->estado,
                'estado_pago' => $i->estado_pago, 'metodo_pago' => $i->metodo_pago, 'monto' => (float) $i->monto_pago,
                'fecha_pago' => $i->fecha_pago, 'comprobante' => $i->comprobante_pago_url ? 'Sí' : 'No',
                'progreso' => (float) $i->porcentaje_progreso, 'fecha_completado' => $i->fecha_completado,
            ]);
        } elseif ($type === 'usuarios') {
            $query = Usuario::with('rol')->withCount([
                'inscripciones',
                'certificados',
                'inscripciones as completados' => fn ($q) => $q->whereNotNull('fecha_completado')
            ])->orderByDesc('fecha_creacion');
            $this->applyDateRange($query, 'fecha_creacion', $filters);
            $query->when($filters['status'] ?? null, fn ($q, $v) => $q->where('estado', $v));
            $query->when($search !== '', fn ($q) => $q->where(fn ($i) => $i->where('nombres', 'like', "%{$search}%")->orWhere('apellidos', 'like', "%{$search}%")->orWhere('correo', 'like', "%{$search}%")));
            $rows = $query->get()->map(fn ($u) => [
                'id' => $u->id, 'fecha_registro' => $u->fecha_creacion, 'nombre' => trim($u->nombres . ' ' . $u->apellidos),
                'correo' => $u->correo, 'ci' => $u->ci, 'telefono' => $u->telefono, 'rol' => $u->rol->nombre ?? '',
                'estado' => $u->estado, 'verificado' => $u->correo_verificado ? 'Sí' : 'No',
                'ultimo_acceso' => $u->ultimo_login, 'fecha_actualizacion' => $u->fecha_actualizacion,
                'inscripciones' => $u->inscripciones_count, 'certificados' => $u->certificados_count,
                'completados' => $u->completados,
            ]);
        } elseif ($type === 'cursos') {
            $query = Curso::with(['categoria', 'instructor'])
                ->withCount([
                    'inscripciones',
                    'inscripciones as activos' => fn ($q) => $q->where('estado', 'ACTIVO'),
                    'inscripciones as completados' => fn ($q) => $q->whereNotNull('fecha_completado')
                ])
                ->withSum('inscripciones as ingresos', 'monto_pago')
                ->orderByDesc('fecha_creacion');
            $this->applyDateRange($query, 'fecha_creacion', $filters);
            $query->when($filters['status'] ?? null, fn ($q, $v) => $q->where('publicado', $v === 'PUBLICADO'));
            $query->when($search !== '', fn ($q) => $q->where('titulo', 'like', "%{$search}%"));
            $rows = $query->get()->map(fn ($c) => [
                'id' => $c->id, 'fecha_creacion' => $c->fecha_creacion, 'curso' => $c->titulo, 'categoria' => $c->categoria->nombre ?? '',
                'instructor' => trim(($c->instructor->nombres ?? '') . ' ' . ($c->instructor->apellidos ?? '')), 'nivel' => $c->nivel,
                'tipo' => $c->tipo_curso, 'estado' => $c->publicado ? 'PUBLICADO' : 'BORRADOR',
                'precio' => (float) ($c->precio ?? 0), 'inscripciones' => $c->inscripciones_count, 'inscritos' => $c->inscripciones_count,
                'publicado' => $c->publicado ? 'Sí' : 'No', 'certificado' => $c->certificado_habilitado ? 'Sí' : 'No',
                'ultima_actualizacion' => $c->fecha_actualizacion,
                'activos' => $c->activos, 'completados' => $c->completados,
                'ingresos' => (float) ($c->ingresos ?? 0),
            ]);
        } elseif ($type === 'certificados') {
            $query = Certificado::with(['usuario', 'curso'])->orderByDesc('fecha_emision');
            $this->applyDateRange($query, 'fecha_emision', $filters);
            $query->when($filters['course_id'] ?? null, fn ($q, $v) => $q->where('curso_id', $v));
            $query->when($search !== '', fn ($q) => $q->where('codigo_certificado', 'like', "%{$search}%"));
            $rows = $query->get()->map(fn ($c) => [
                'id' => $c->id, 'fecha' => $c->fecha_emision, 'codigo' => $c->codigo_certificado,
                'estudiante' => trim(($c->usuario->nombres ?? '') . ' ' . ($c->usuario->apellidos ?? '')), 'curso' => $c->curso->titulo ?? '',
                'pdf' => $c->pdf_url ? 'Sí' : 'No',
                'url_pdf' => $c->pdf_url ?? '',
                'estado_validacion' => $c->pdf_url ? 'Válido' : 'No válido',
            ]);
        } else {
            $query = IntentoEvaluacion::with(['usuario', 'evaluacion.curso'])
                ->selectRaw('*, (select count(*) from intentos_evaluacion where usuario_id = intentos_evaluacion.usuario_id and evaluacion_id = intentos_evaluacion.evaluacion_id) as intentos')
                ->orderByDesc('fecha_inicio');
            $this->applyDateRange($query, 'fecha_inicio', $filters);
            $query->when($filters['status'] ?? null, fn ($q, $v) => $q->where('aprobado', $v === 'APROBADO'));
            $query->when($filters['course_id'] ?? null, fn ($q, $v) => $q->whereHas('evaluacion', fn ($e) => $e->where('curso_id', $v)));
            $rows = $query->get()->map(fn ($i) => [
                'id' => $i->id, 'fecha_inicio' => $i->fecha_inicio, 'estudiante' => trim(($i->usuario->nombres ?? '') . ' ' . ($i->usuario->apellidos ?? '')),
                'evaluacion' => $i->evaluacion->titulo ?? '', 'curso' => $i->evaluacion->curso->titulo ?? '', 'nota' => (float) ($i->nota ?? 0),
                'estado' => $i->aprobado === null ? 'PENDIENTE' : ($i->aprobado ? 'APROBADO' : 'REPROBADO'), 'fecha_finalizacion' => $i->fecha_fin,
                'duracion' => $i->fecha_fin && $i->fecha_inicio ? $this->formatDuration(Carbon::parse($i->fecha_inicio)->diffInSeconds(Carbon::parse($i->fecha_fin))) : '',
                'intentos' => (int) ($i->intentos ?? 0),
            ]);
        }

        return response()->json(['type' => $type, 'rows' => $rows->values(), 'total' => $rows->count(), 'sum' => $rows->sum(fn ($r) => (float) ($r['monto'] ?? $r['precio'] ?? 0))]);
    }

    private function applyDateRange($query, string $column, array $filters): void
    {
        $query->when($filters['from'] ?? null, fn ($q, $value) => $q->whereDate($column, '>=', $value));
        $query->when($filters['to'] ?? null, fn ($q, $value) => $q->whereDate($column, '<=', $value));
    }

    private function formatDuration(int $seconds): string
    {
        if ($seconds < 60) {
            return "{$seconds} seg";
        }
        $minutes = intdiv($seconds, 60);
        $remainingSeconds = $seconds % 60;
        return $remainingSeconds === 0 ? "{$minutes} min" : "{$minutes} min {$remainingSeconds} seg";
    }

    public function getDashboardStats()
    {
        $totalCursos = Curso::count();
        $totalEstudiantes = Usuario::whereHas('rol', function($q) {
            $q->where('nombre', 'estudiante');
        })->count();
        $totalInscripciones = Inscripcion::count();
        $totalVentas = Curso::sum('precio');
        $pendingInscriptions = Inscripcion::where('estado', 'PENDIENTE')->count();
        $weeklyInscripciones = Inscripcion::where('fecha_inscripcion', '>=', Carbon::now()->subDays(7))->count();
        $completedInscripciones = Inscripcion::whereNotNull('fecha_completado')->count();
        $completionRate = $totalInscripciones > 0 ? round(($completedInscripciones / $totalInscripciones) * 100, 1) : 0;

        $trend = $this->getTrendData();
        $activities = $this->getRecentActivities();

        return response()->json([
            'totalCursos' => $totalCursos,
            'totalEstudiantes' => $totalEstudiantes,
            'totalInscripciones' => $totalInscripciones,
            'totalVentas' => $totalVentas ?: 0,
            'trend' => $trend,
            'activities' => $activities,
            'pendingInscriptions' => $pendingInscriptions,
            'weeklyInscripciones' => $weeklyInscripciones,
            'completionRate' => $completionRate
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
                'year' => $date->year,
                'month_number' => $date->month,
                'start' => $date->copy()->startOfMonth()->toDateString(),
                'end' => $date->copy()->endOfMonth()->toDateString(),
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

    public function getEnrollmentsByCourse(Request $request)
    {
        $from = $request->query('from');
        $to = $request->query('to');

        $cursos = Curso::withCount(['inscripciones' => function ($query) use ($from, $to) {
            if ($from) {
                $query->whereDate('fecha_inscripcion', '>=', $from);
            }
            if ($to) {
                $query->whereDate('fecha_inscripcion', '<=', $to);
            }
        }])
            ->orderBy('inscripciones_count', 'desc')
            ->take(8)
            ->get();

        return response()->json($cursos->map(function ($curso) {
            return [
                'titulo' => $curso->titulo,
                'inscripciones' => $curso->inscripciones_count
            ];
        }));
    }

    public function getEnrollmentsByDay(Request $request)
    {
        $from = $request->query('from');
        $to = $request->query('to');
        if ($from && $to) {
            $start = Carbon::parse($from)->startOfDay();
            $end = Carbon::parse($to)->endOfDay();
            $inscripciones = Inscripcion::whereBetween('fecha_inscripcion', [$start, $end])->get();
            $period = new \DatePeriod($start, new \DateInterval('P1D'), $end->copy()->addDay());
        } else {
            $days = max(7, min(30, (int) $request->query('days', 14)));
            $start = Carbon::now()->subDays($days - 1)->startOfDay();
            $end = Carbon::now()->endOfDay();
            $inscripciones = Inscripcion::where('fecha_inscripcion', '>=', $start)->get();
            $period = new \DatePeriod($start, new \DateInterval('P1D'), $end->copy()->addDay());
        }

        $data = [];
        foreach ($period as $dateTime) {
            $date = Carbon::instance($dateTime);
            $label = $date->format('d');
            $count = $inscripciones->filter(function ($ins) use ($date) {
                $insDate = Carbon::parse($ins->fecha_inscripcion);
                return $insDate->isSameDay($date);
            })->count();

            $data[] = [
                'day' => $label,
                'date' => $date->toDateString(),
                'count' => $count
            ];
        }

        return response()->json($data);
    }

    public function getRevenueByMonth(Request $request)
    {
        $from = $request->query('from');
        $to = $request->query('to');
        $monthsNames = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];

        if ($from && $to) {
            $start = Carbon::parse($from)->startOfMonth();
            $end = Carbon::parse($to)->endOfMonth();
            $pagos = Inscripcion::whereNotNull('fecha_pago')->whereBetween('fecha_pago', [$start, $end])->get();
            $period = new \DatePeriod($start, new \DateInterval('P1M'), $end->copy()->addMonth());
        } else {
            $months = max(3, min(12, (int) $request->query('months', 6)));
            $start = Carbon::now()->subMonths($months - 1)->startOfMonth();
            $pagos = Inscripcion::whereNotNull('fecha_pago')->where('fecha_pago', '>=', $start)->get();
            $period = new \DatePeriod($start, new \DateInterval('P1M'), Carbon::now()->copy()->addMonth());
        }

        $data = [];
        foreach ($period as $dateTime) {
            $date = Carbon::instance($dateTime);
            $label = $monthsNames[$date->month - 1];
            $sum = $pagos->filter(function ($ins) use ($date) {
                $insDate = Carbon::parse($ins->fecha_pago);
                return $insDate->month === $date->month && $insDate->year === $date->year;
            })->sum('monto_pago');

            $data[] = [
                'month' => $label,
                'revenue' => round($sum, 2)
            ];
        }

        return response()->json($data);
    }

    public function getApprovalRateByCourse(Request $request)
    {
        $from = $request->query('from');
        $to = $request->query('to');
        $query = IntentoEvaluacion::with(['evaluacion.curso']);
        if ($from) {
            $query->whereDate('fecha_fin', '>=', $from);
        }
        if ($to) {
            $query->whereDate('fecha_fin', '<=', $to);
        }

        $attempts = $query->get();
        $courses = [];

        foreach ($attempts as $attempt) {
            if (! $attempt->evaluacion || ! $attempt->evaluacion->curso) {
                continue;
            }

            $courseId = $attempt->evaluacion->curso->id;
            if (! isset($courses[$courseId])) {
                $courses[$courseId] = [
                    'titulo' => $attempt->evaluacion->curso->titulo,
                    'aprobados' => 0,
                    'reprobados' => 0,
                    'total' => 0
                ];
            }

            $courses[$courseId]['total']++;
            if ($attempt->aprobado) {
                $courses[$courseId]['aprobados']++;
            } elseif ($attempt->aprobado === false) {
                $courses[$courseId]['reprobados']++;
            }
        }

        $results = array_values(array_map(function ($course) {
            $rate = $course['total'] > 0 ? round(($course['aprobados'] * 100) / $course['total'], 1) : 0;
            return [
                'titulo' => $course['titulo'],
                'aprobados' => $course['aprobados'],
                'reprobados' => $course['reprobados'],
                'total' => $course['total'],
                'approval_rate' => $rate
            ];
        }, $courses));

        usort($results, fn($a, $b) => $b['total'] <=> $a['total']);

        return response()->json(array_slice($results, 0, 6));
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
