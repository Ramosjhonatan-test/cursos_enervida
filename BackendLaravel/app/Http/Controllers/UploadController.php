<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class UploadController extends Controller
{
    /**
     * Directorio base dentro de /public donde se guardan los archivos.
     * Accesible directamente vía web sin necesitar symlinks.
     */
    private function getUploadBasePath(): string
    {
        return public_path('uploads');
    }

    /**
     * Genera la URL pública completa de un archivo guardado.
     * Usa la URL real de la petición para funcionar en cualquier puerto/entorno.
     */
    private function getPublicUrl(string $relativePath): string
    {
        $baseUrl = rtrim(request()->getSchemeAndHttpHost(), '/');
        return $baseUrl . '/uploads/' . ltrim($relativePath, '/');
    }

    /**
     * Sube un archivo y lo guarda en public/uploads/{folder}/
     */
    public function upload(Request $request)
    {
        $request->validate([
            'file'   => 'required|file|max:921600', // max 900MB para videos
            'folder' => 'nullable|string|max:100',
        ]);

        $folder    = $request->input('folder', 'general');
        $uploadDir = $this->getUploadBasePath() . '/' . $folder;

        // Crear directorio si no existe
        if (!File::exists($uploadDir)) {
            File::makeDirectory($uploadDir, 0755, true);
        }

        $file         = $request->file('file');
        $originalName = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $extension    = $file->getClientOriginalExtension();
        $filename     = time() . '_' . \Illuminate\Support\Str::slug($originalName) . '.' . $extension;

        $file->move($uploadDir, $filename);

        $relativePath = $folder . '/' . $filename;
        $url          = $this->getPublicUrl($relativePath);
        $size         = File::size($uploadDir . '/' . $filename);

        return response()->json([
            'message'  => 'Archivo subido con éxito',
            'url'      => $url,
            'path'     => $relativePath,
            'mimetype' => $file->getClientMimeType(),
            'size'     => $size,
        ], 201);
    }

    /**
     * Lista todos los archivos en public/uploads/ con información de uso.
     */
    public function findAll()
    {
        $basePath = $this->getUploadBasePath();

        if (!File::exists($basePath)) {
            return response()->json([]);
        }

        $allFiles = File::allFiles($basePath);
        $fileList = [];

        foreach ($allFiles as $file) {
            $filename = $file->getFilename();

            // Ignorar archivos del sistema
            if (str_starts_with($filename, '.')) {
                continue;
            }

            $relativePath = str_replace('\\', '/', $file->getRelativePathname());
            $url          = $this->getPublicUrl($relativePath);
            $size         = $file->getSize();
            $createdAt    = date('Y-m-d H:i:s', $file->getMTime());
            $usages       = $this->checkUsage($filename, $url);

            $fileList[] = [
                'filename'  => $filename,
                'path'      => $relativePath,
                'size'      => $size,
                'createdAt' => $createdAt,
                'isUsed'    => count($usages) > 0,
                'usages'    => $usages,
                'url'       => $url,
            ];
        }

        return response()->json($fileList);
    }

    /**
     * Verifica si un archivo está siendo referenciado en la base de datos.
     */
    private function checkUsage(string $filename, string $url): array
    {
        $usages = [];

        // 1. Usuarios (foto de perfil)
        $usuario = \App\Models\Usuario::where('imagen_perfil', 'like', "%{$filename}%")
            ->orWhere('imagen_perfil', 'like', "%{$url}%")
            ->first();
        if ($usuario) {
            $usages[] = [
                'type' => 'Usuario',
                'name' => "{$usuario->nombres} {$usuario->apellidos}",
                'id'   => $usuario->id,
            ];
        }

        // 2. Cursos (miniatura)
        $curso = \App\Models\Curso::where('miniatura_url', 'like', "%{$filename}%")
            ->orWhere('miniatura_url', 'like', "%{$url}%")
            ->first();
        if ($curso) {
            $usages[] = [
                'type' => 'Curso (Miniatura)',
                'name' => $curso->titulo,
                'id'   => $curso->id,
            ];
        }

        // 3. Plantillas de Certificado
        $plantilla = \App\Models\CertificadoPlantilla::where('background_url', 'like', "%{$filename}%")
            ->orWhere('background_url', 'like', "%{$url}%")
            ->first();
        if ($plantilla) {
            $usages[] = [
                'type' => 'Plantilla Certificado',
                'name' => $plantilla->nombre,
                'id'   => $plantilla->curso_id,
            ];
        }

        // 4. Lecciones (video o PDF)
        $leccion = \App\Models\Leccion::where('video_url', 'like', "%{$filename}%")
            ->orWhere('video_url', 'like', "%{$url}%")
            ->orWhere('pdf_url', 'like', "%{$filename}%")
            ->orWhere('pdf_url', 'like', "%{$url}%")
            ->first();
        if ($leccion) {
            $usages[] = [
                'type' => 'Lección',
                'name' => $leccion->titulo,
                'id'   => $leccion->id,
            ];
        }

        // 5. Certificados emitidos (PDF generado)
        $cert = \App\Models\Certificado::where('pdf_url', 'like', "%{$filename}%")
            ->orWhere('pdf_url', 'like', "%{$url}%")
            ->first();
        if ($cert) {
            $usages[] = [
                'type' => 'Certificado Emitido',
                'name' => $cert->codigo_certificado,
                'id'   => $cert->id,
            ];
        }

        return $usages;
    }

    /**
     * Elimina un archivo de public/uploads/.
     */
    public function remove(string $filename)
    {
        $basePath = $this->getUploadBasePath();
        $allFiles = File::allFiles($basePath);

        foreach ($allFiles as $file) {
            if ($file->getFilename() === $filename) {
                File::delete($file->getPathname());
                return response()->json(['message' => 'Archivo eliminado con éxito']);
            }
        }

        return response()->json(['message' => 'Archivo no encontrado'], 404);
    }

    /**
     * Elimina múltiples archivos de public/uploads/.
     */
    public function removeBulk(Request $request)
    {
        $filenames    = $request->input('filenames', []);
        $deletedCount = 0;
        $errors       = [];
        $basePath     = $this->getUploadBasePath();

        foreach ($filenames as $filename) {
            $url    = $this->getPublicUrl($filename);
            $usages = $this->checkUsage($filename, $url);

            if (count($usages) > 0) {
                $errors[] = "El archivo {$filename} está en uso y no puede eliminarse.";
                continue;
            }

            $allFiles = File::allFiles($basePath);
            $deleted  = false;

            foreach ($allFiles as $file) {
                if ($file->getFilename() === $filename) {
                    File::delete($file->getPathname());
                    $deletedCount++;
                    $deleted = true;
                    break;
                }
            }

            if (!$deleted) {
                $errors[] = "Archivo {$filename} no encontrado.";
            }
        }

        return response()->json([
            'message'      => "{$deletedCount} archivos eliminados con éxito",
            'deletedCount' => $deletedCount,
            'errors'       => count($errors) > 0 ? $errors : null,
        ]);
    }

    /**
     * Sirve archivos desde public/uploads/ vía API (fallback para URLs antiguas).
     * Los archivos nuevos ya son accesibles directamente como recursos web estáticos.
     */
    public function serveWildcardFile(string $path)
    {
        // Primero intentar en public/uploads/
        $publicPath = public_path('uploads/' . $path);
        if (File::exists($publicPath)) {
            return response()->file($publicPath);
        }

        // Fallback: intentar ruta directa en public/
        $directPath = public_path($path);
        if (File::exists($directPath)) {
            return response()->file($directPath);
        }

        // Fallback legacy: storage/app/public/
        $storagePath = storage_path('app/public/' . $path);
        if (File::exists($storagePath)) {
            return response()->file($storagePath);
        }

        abort(404);
    }
}
