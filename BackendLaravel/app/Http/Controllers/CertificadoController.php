<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Certificado;
use App\Models\Curso;
use App\Models\IntentoEvaluacion;
use Barryvdh\DomPDF\Facade\Pdf;

class CertificadoController extends Controller
{
    public function index()
    {
        return response()->json(Certificado::with(['usuario', 'curso'])->get());
    }

    public function show($id)
    {
        return response()->json(Certificado::with(['usuario', 'curso'])->findOrFail($id));
    }

    public function emitirPorUsuarioCurso(Request $request)
    {
        $data = $request->validate([
            'usuario_id' => 'required|exists:usuarios,id',
            'curso_id' => 'required|exists:cursos,id',
            'force' => 'sometimes|boolean',
        ]);

        $certificadoExistente = Certificado::where('usuario_id', $data['usuario_id'])
            ->where('curso_id', $data['curso_id'])
            ->first();

        if ($certificadoExistente) {
            return response()->json([
                'created' => false,
                'certificado' => $certificadoExistente,
                'message' => 'El certificado ya existe para este estudiante y curso.'
            ], 200);
        }

        $intentoAprobado = IntentoEvaluacion::where('usuario_id', $data['usuario_id'])
            ->whereHas('evaluacion', function ($query) use ($data) {
                $query->where('curso_id', $data['curso_id']);
            })
            ->where('aprobado', true)
            ->orderByDesc('fecha_fin')
            ->first();

        if (!$intentoAprobado && empty($data['force'])) {
            return response()->json([
                'message' => 'El estudiante no tiene una evaluacion aprobada para este curso.'
            ], 422);
        }

        $curso = Curso::findOrFail($data['curso_id']);
        $codigo = $this->generarCodigoCertificado($curso);

        $certificado = Certificado::create([
            'usuario_id' => $data['usuario_id'],
            'curso_id' => $data['curso_id'],
            'codigo_certificado' => $codigo,
            'pdf_url' => '',
        ]);

        return response()->json([
            'created' => true,
            'certificado' => $certificado,
            'message' => (['force'] ?? false) ? 'Certificado emitido manualmente correctamente.' : 'Certificado emitido correctamente.'
        ], 201);
    }

    public function sampleQr()
    {
        $sampleText = 'VALIDACION DE CERTIFICADO ENERVIDA';
        $svg = \F9WebLtd\QrCode\Facades\QrCode::size(160)
            ->color(0, 0, 0)
            ->backgroundColor(255, 255, 255)
            ->generate($sampleText);

        return response($svg, 200)
            ->header('Content-Type', 'image/svg+xml')
            ->header('Cache-Control', 'no-cache, no-store, must-revalidate');
    }

    public function downloadPdf($id)
    {
        $certificado = Certificado::with(['usuario', 'curso.categoria', 'curso.instructor'])->findOrFail($id);

        $plantilla = \App\Models\CertificadoPlantilla::where('curso_id', $certificado->curso_id)->first();

        if ($plantilla) {
            $bgUrl = $plantilla->background_url;
            $localBgPath = $this->getLocalFilePath($bgUrl);
            
            if (!$localBgPath && $this->isLocalUrl($bgUrl)) {
                $bgPathForPdf = '';
            } else {
                $bgPathForPdf = $localBgPath ? $localBgPath : $bgUrl;
            }

            $config = $plantilla->config;
            $width = $config['logicalWidth'] ?? 1000;
            $height = $config['logicalHeight'] ?? 707;
            
            $elements = $config['elements'] ?? [];

            $frontendUrl = env('FRONTEND_URL');
            $urlValidacion = rtrim($frontendUrl, '/') . '/verificar/' . $certificado->codigo_certificado;
            $qrCodeBase64 = base64_encode(\F9WebLtd\QrCode\Facades\QrCode::size(150)->generate($urlValidacion));

            foreach ($elements as &$el) {
                if ($el['type'] === 'text') {
                    $el['rendered_content'] = $this->renderCertificateText($el['content'] ?? '', $certificado);
                } elseif ($el['type'] === 'image') {
                    $localImgPath = $this->getLocalFilePath($el['url'] ?? '');
                    if (!$localImgPath && $this->isLocalUrl($el['url'] ?? '')) {
                        $el['full_url'] = '';
                    } else {
                        $el['full_url'] = $localImgPath ? $localImgPath : ($el['url'] ?? '');
                    }
                } elseif ($el['type'] === 'qr') {
                    $el['qr_code_base64'] = $qrCodeBase64;
                }
            }

            $pdf = Pdf::loadView('certificado_preview', [
                'width' => $width,
                'height' => $height,
                'background_url' => $bgPathForPdf,
                'elements' => $elements
            ])->setPaper([0, 0, $width, $height])
              ->setOption('isRemoteEnabled', true)
              ->setOption('isHtml5ParserEnabled', true);

            return $pdf->download('certificado_' . $certificado->codigo_certificado . '.pdf');
        }

        $data = [
            'nombres' => $certificado->usuario->nombres,
            'apellidos' => $certificado->usuario->apellidos,
            'curso' => $certificado->curso->titulo,
            'codigo' => $certificado->codigo_certificado,
            'fecha' => $certificado->fecha_emision,
        ];

        // Se usarÃ­a una vista resources/views/certificado.blade.php
        $pdf = Pdf::loadView('certificado', $data)
            ->setPaper('a4', 'landscape')
            ->setOption('isRemoteEnabled', true)
            ->setOption('isHtml5ParserEnabled', true);
        return $pdf->download('certificado_' . $certificado->codigo_certificado . '.pdf');
    }

    /**
     * Genera la abreviatura de 2 o 3 letras a partir del slug del curso.
     */
    private function obtenerAbreviaturaDesdeSlug(string $slug): string
    {
        $curso = Curso::where('slug', $slug)->first();
        if ($curso) {
            return $curso->obtenerPrefijoCertificado();
        }

        $palabras = array_filter(
            preg_split('/[^a-z0-9]+/i', $slug),
            fn($p) => !in_array(strtolower($p), ['de', 'con', 'y', 'a', 'la', 'el', 'en', 'para', 'del', 'los', 'las', 'por', 'al', 'lo'])
        );

        $palabras = array_values($palabras);
        if (count($palabras) >= 3) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1) . substr($palabras[2], 0, 1));
        }
        if (count($palabras) === 2) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1));
        }
        if (count($palabras) === 1) {
            return strtoupper(substr($palabras[0], 0, 3));
        }

        return strtoupper(substr($slug, 0, 3));
    }

    /**
     * Genera el cÃ³digo Ãºnico del certificado bajo la norma XXVVAANNNN.
     */
    private function generarCodigoCertificado(Curso $curso): string
    {
        $xx = $this->obtenerAbreviaturaDesdeSlug($curso->slug);
        $vv = sprintf('%02d', $curso->edicion_actual ?? 1);
        $aa = now()->format('y');
        $prefijo = $xx . $vv . $aa;

        $ultimoCertificado = Certificado::where('codigo_certificado', 'like', $prefijo . '%')
            ->orderBy('codigo_certificado', 'desc')
            ->first();

        $siguiente = 1;
        if ($ultimoCertificado) {
            $ultimoCorrelativo = substr($ultimoCertificado->codigo_certificado, -4);
            if (is_numeric($ultimoCorrelativo)) {
                $siguiente = intval($ultimoCorrelativo) + 1;
            }
        }

        $nnnn = sprintf('%04d', $siguiente);

        return $prefijo . $nnnn;
    }

    private function renderCertificateText($content, $certificado)
    {
        if (empty($content)) return '';

        $fechaEmision = \Carbon\Carbon::parse($certificado->fecha_emision)->format('d/m/Y');
        $nombreEstudiante = trim(($certificado->usuario->nombres ?? '') . ' ' . ($certificado->usuario->apellidos ?? ''));
        $nombreInstructor = trim(($certificado->curso->instructor->nombres ?? '') . ' ' . ($certificado->curso->instructor->apellidos ?? ''));

        return str_replace(
            ['{{estudiante}}', '{{curso}}', '{{categoria}}', '{{nivel}}', '{{tipo_curso}}', '{{fecha}}', '{{codigo}}', '{{instructor}}', '{{ci}}', '{{telefono}}'],
            [
                $nombreEstudiante,
                $certificado->curso->titulo ?? '',
                $certificado->curso->categoria->nombre ?? '',
                $certificado->curso->nivel ?? '',
                $certificado->curso->tipo_curso ?? '',
                $fechaEmision,
                $certificado->codigo_certificado ?? '',
                $nombreInstructor,
                $certificado->usuario->ci ?? '',
                $certificado->usuario->telefono ?? ''
            ],
            $content
        );
    }

    private function getLocalFilePath($url)
    {
        if (empty($url)) return null;

        $path = parse_url($url, PHP_URL_PATH);
        if (!$path) return null;

        $path = ltrim($path, '/');

        // 1. Direct match in public folder
        if (file_exists(public_path($path))) {
            return public_path($path);
        }

        // 2. Normalize by removing prefix aliases
        $cleanPath = $path;
        if (str_starts_with($cleanPath, 'api/')) {
            $cleanPath = substr($cleanPath, 4);
        }
        if (str_starts_with($cleanPath, 'storage/')) {
            $cleanPath = substr($cleanPath, 8);
        }

        // Check in public folder
        if (file_exists(public_path($cleanPath))) {
            return public_path($cleanPath);
        }

        // Check in storage folder (legacy files)
        if (file_exists(storage_path('app/public/' . $cleanPath))) {
            return storage_path('app/public/' . $cleanPath);
        }
        if (file_exists(storage_path('app/public/' . $path))) {
            return storage_path('app/public/' . $path);
        }

        // Fallback: check in public/uploads/
        if (file_exists(public_path('uploads/' . $cleanPath))) {
            return public_path('uploads/' . $cleanPath);
        }

        return null;
    }

    private function isLocalUrl($url)
    {
        if (empty($url)) return false;

        $host = parse_url($url, PHP_URL_HOST);
        if (!$host) {
            return true;
        }

        $localHosts = [
            'localhost',
            '127.0.0.1',
            request()->getHost()
        ];

        return in_array(strtolower($host), $localHosts);
    }

    public function findMyCertificados()
    {
        $usuarioId = auth('api')->id();
        $certificados = Certificado::with(['curso'])
            ->where('usuario_id', $usuarioId)
            ->get();
        return response()->json($certificados);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'usuario_id' => 'required|exists:usuarios,id',
            'curso_id' => 'required|exists:cursos,id',
            'codigo_certificado' => 'required|string|unique:certificados',
            'pdf_url' => 'nullable|string'
        ]);

        if (!isset($data['pdf_url'])) {
            $data['pdf_url'] = '';
        }

        $certificado = Certificado::create($data);
        return response()->json($certificado, 201);
    }

    public function importJson(Request $request)
    {
        $request->validate([
            'file' => ['required', 'file', 'mimes:json,txt'],
        ]);

        $sourcePath = $request->file('file')->getRealPath();
        $sourceContent = file_get_contents($sourcePath);
        $importData = json_decode($sourceContent, true);

        if (!is_array($importData)) {
            return response()->json([
                'message' => 'El archivo JSON enviado no tiene un formato vÃ¡lido.'
            ], 422);
        }

        $jsonPath = storage_path('app/certificados.json');
        $existingData = [];

        if (file_exists($jsonPath)) {
            $existingContent = file_get_contents($jsonPath);
            $decodedExisting = json_decode($existingContent, true);
            if (is_array($decodedExisting)) {
                $existingData = $decodedExisting;
            }
        }

        $normalizedImported = [];
        foreach ($importData as $record) {
            if (!is_array($record)) {
                continue;
            }

            $normalizedImported[] = $this->normalizeLocalCertificadoRecord($record);
        }

        $mergedData = $existingData;
        $existingCodes = [];

        foreach ($mergedData as $record) {
            $code = strtolower(trim($record['codigo_certificado'] ?? $record['codigo'] ?? $record['certificado'] ?? ''));
            if ($code !== '') {
                $existingCodes[$code] = true;
            }
        }

        foreach ($normalizedImported as $record) {
            $code = strtolower(trim($record['codigo_certificado'] ?? $record['codigo'] ?? $record['certificado'] ?? ''));
            if ($code === '' || isset($existingCodes[$code])) {
                continue;
            }

            $mergedData[] = $record;
            $existingCodes[$code] = true;
        }

        file_put_contents($jsonPath, json_encode($mergedData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));

        return response()->json([
            'message' => 'ImportaciÃ³n completada en el JSON local.',
            'importados' => count($normalizedImported),
            'total_final' => count($mergedData)
        ]);
    }

    private function normalizeLocalCertificadoRecord(array $record): array
    {
        $codigo = $record['codigo_certificado'] ?? $record['codigo'] ?? $record['Codigo'] ?? $record['certificado'] ?? '';
        $nombre = $record['nombre_completo'] ?? $record['nombre'] ?? $record['Nombre Completo'] ?? '';
        $curso = $record['curso'] ?? $record['Curso'] ?? '';
        $fecha = $record['fecha_emision'] ?? $record['fecha'] ?? $record['Fecha'] ?? '';
        $inicio = $record['inicio'] ?? $record['Inicio'] ?? '';
        $fin = $record['fin'] ?? $record['Fin'] ?? '';
        $horas = $record['horas'] ?? $record['Horas'] ?? '';
        $version = $record['version'] ?? $record['Version'] ?? '';

        return [
            'codigo_certificado' => $codigo,
            'codigo' => $codigo,
            'certificado' => $codigo,
            'nombre_completo' => $nombre,
            'nombre' => $nombre,
            'curso' => $curso,
            'fecha_emision' => $fecha,
            'fecha' => $fecha,
            'inicio' => $inicio,
            'fin' => $fin,
            'horas' => $horas,
            'version' => $version,
            'ci' => '',
            'instructor' => ''
        ];
    }

    public function validarCertificado($codigo)
    {
        $certificado = Certificado::with(['usuario', 'curso.categoria', 'curso.instructor'])
            ->where('codigo_certificado', $codigo)
            ->first();

        if ($certificado) {
            return response()->json([
                'valido' => true,
                'estudiante' => trim(($certificado->usuario->nombres ?? '') . ' ' . ($certificado->usuario->apellidos ?? '')),
                'ci' => $certificado->usuario->ci ?? 'N/A',
                'curso' => $certificado->curso->titulo ?? '',
                'categoria' => $certificado->curso->categoria->nombre ?? '',
                'fecha_emision' => \Carbon\Carbon::parse($certificado->fecha_emision)->format('d/m/Y'),
                'codigo_certificado' => $certificado->codigo_certificado,
                'instructor' => trim(($certificado->curso->instructor->nombres ?? '') . ' ' . ($certificado->curso->instructor->apellidos ?? ''))
            ]);
        }

        $jsonPath = storage_path('app/certificados.json');
        if (file_exists($jsonPath)) {
            $jsonContent = file_get_contents($jsonPath);
            $participantes = json_decode($jsonContent, true);
            if (is_array($participantes)) {
                $codigoLower = strtolower(trim($codigo));
                foreach ($participantes as $rawParticipant) {
                    $participant = $this->normalizeLocalCertificadoRecord($rawParticipant);
                    $participantCode = strtolower(trim($participant['codigo_certificado'] ?? $participant['codigo'] ?? $participant['certificado'] ?? ''));
                    $participantName = strtolower(trim($participant['nombre'] ?? $participant['nombre_completo'] ?? ''));
                    $participantCourse = strtolower(trim($participant['curso'] ?? ''));

                    if ($participantCode === $codigoLower || str_contains($participantName, $codigoLower) || str_contains($participantCourse, $codigoLower)) {
                        return response()->json([
                            'valido' => true,
                            'estudiante' => $participant['nombre'] ?? '',
                            'ci' => $participant['ci'] ?? 'N/A',
                            'curso' => $participant['curso'] ?? '',
                            'categoria' => 'Campus Enervida',
                            'fecha_emision' => $participant['fecha'] ?? $participant['fecha_emision'] ?? '',
                            'codigo_certificado' => $participant['codigo_certificado'] ?? $participant['certificado'] ?? '',
                            'instructor' => $participant['instructor'] ?? 'Ing. Boris Mario Ardaya Limachi'
                        ]);
                    }
                }
            }
        }

        abort(404, 'Certificado no encontrado');
    }
}

