<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CertificadoPlantilla;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Storage;

class CertificadoPlantillaController extends Controller
{
    public function preview($plantillaId)
    {
        $plantilla = CertificadoPlantilla::findOrFail($plantillaId);

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

        foreach ($elements as &$el) {
            if ($el['type'] === 'text') {
                $el['rendered_content'] = $this->renderPlaceholderText($el['content'] ?? '');
            } elseif ($el['type'] === 'image') {
                $localImgPath = $this->getLocalFilePath($el['url'] ?? '');
                if (!$localImgPath && $this->isLocalUrl($el['url'] ?? '')) {
                    $el['full_url'] = '';
                } else {
                    $el['full_url'] = $localImgPath ? $localImgPath : ($el['url'] ?? '');
                }
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

        return $pdf->stream('preview_certificado.pdf');
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

    private function renderPlaceholderText($content)
    {
        if (empty($content)) return '';
        
        return str_replace(
            ['{{estudiante}}', '{{curso}}', '{{categoria}}', '{{nivel}}', '{{tipo_curso}}', '{{fecha}}', '{{codigo}}', '{{instructor}}', '{{ci}}', '{{telefono}}'],
            ['JUAN PÉREZ GARCÍA', 'CURSO DE ENERGÍA SOLAR FOTOVOLTAICA', 'ENERGÍA RENOVABLE', 'INTERMEDIO', 'GRABADO', date('d/m/Y'), 'EV01260004', 'ING. CARLOS GÓMEZ', '1234567 LP', '+591 77777777'],
            $content
        );
    }

    public function showByCurso($cursoId)
    {
        $plantilla = CertificadoPlantilla::where('curso_id', $cursoId)->first();
        return response()->json($plantilla);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id|unique:certificado_plantillas,curso_id',
            'nombre' => 'required|string',
            'background_url' => 'required|string',
            'config' => 'required|array',
        ]);

        $plantilla = CertificadoPlantilla::create($data);
        return response()->json($plantilla, 201);
    }

    public function update(Request $request, $id)
    {
        $plantilla = CertificadoPlantilla::findOrFail($id);
        
        $data = $request->validate([
            'curso_id' => 'nullable|exists:cursos,id|unique:certificado_plantillas,curso_id,' . $id,
            'nombre' => 'nullable|string',
            'background_url' => 'nullable|string',
            'config' => 'nullable|array',
        ]);

        $plantilla->update($data);
        return response()->json($plantilla);
    }

    public function destroy($id)
    {
        CertificadoPlantilla::findOrFail($id)->delete();
        return response()->json(['message' => 'Plantilla de certificado eliminada']);
    }
}
