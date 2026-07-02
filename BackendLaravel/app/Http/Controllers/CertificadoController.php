<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Certificado;
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

            $frontendUrl = env('FRONTEND_URL', 'http://localhost:5173');
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

        // Se usaría una vista resources/views/certificado.blade.php
        $pdf = Pdf::loadView('certificado', $data)
            ->setPaper('a4', 'landscape')
            ->setOption('isRemoteEnabled', true)
            ->setOption('isHtml5ParserEnabled', true);
        return $pdf->download('certificado_' . $certificado->codigo_certificado . '.pdf');
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

    public function validarCertificado($codigo)
    {
        $certificado = Certificado::with(['usuario', 'curso.categoria', 'curso.instructor'])
            ->where('codigo_certificado', $codigo)
            ->firstOrFail();

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
}
