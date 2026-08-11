<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;

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

    private function sanitizeFolder(string $folder): string
    {
        $clean = preg_replace('/[^A-Za-z0-9_\-]/', '', $folder);
        return $clean === '' ? 'general' : $clean;
    }

    private function sanitizeFilename(string $filename): string
    {
        $name = pathinfo($filename, PATHINFO_FILENAME);
        $ext = pathinfo($filename, PATHINFO_EXTENSION);
        return time() . '_' . Str::slug($name) . '.' . strtolower($ext);
    }

    private function sanitizeRelativePath(string $path): ?string
    {
        $normalized = str_replace(['\\', '/'], DIRECTORY_SEPARATOR, $path);
        $normalized = trim($normalized, DIRECTORY_SEPARATOR);

        if ($normalized === '' || str_contains($normalized, '..')) {
            return null;
        }

        return str_replace(DIRECTORY_SEPARATOR, '/', $normalized);
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
            'file'   => 'required|file|max:921600|mimes:jpg,jpeg,png,gif,pdf,mp4,webm,mov,avi,mp3,doc,docx,xls,xlsx,ppt,pptx,zip',
            'folder' => 'nullable|string|max:100',
        ]);

        $folder    = $this->sanitizeFolder($request->input('folder', 'general'));
        $uploadDir = $this->getUploadBasePath() . '/' . $folder;

        // Crear directorio si no existe
        if (!File::exists($uploadDir)) {
            File::makeDirectory($uploadDir, 0755, true);
        }

        $file         = $request->file('file');
        $filename     = $this->sanitizeFilename($file->getClientOriginalName());

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

        // 5. Inscripciones (comprobante de pago)
        $inscripcion = \App\Models\Inscripcion::where('comprobante_pago_url', 'like', "%{$filename}%")
            ->orWhere('comprobante_pago_url', 'like', "%{$url}%")
            ->first();
        if ($inscripcion) {
            $usuarioNombre = optional($inscripcion->usuario)->nombres ? trim(optional($inscripcion->usuario)->nombres . ' ' . optional($inscripcion->usuario)->apellidos) : 'Sin usuario';
            $usages[] = [
                'type' => 'Inscripción (Comprobante de Pago)',
                'name' => $usuarioNombre !== '' ? $usuarioNombre : "Inscripción #{$inscripcion->id}",
                'id'   => $inscripcion->id,
            ];
        }

        // 6. Certificados emitidos (PDF generado)
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
        if ($filename !== basename($filename)) {
            return response()->json(['message' => 'Nombre de archivo inválido'], 400);
        }

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
            if ($filename !== basename($filename)) {
                $errors[] = "Nombre de archivo inválido: {$filename}.";
                continue;
            }

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
        $sanitized = $this->sanitizeRelativePath($path);
        if ($sanitized === null) {
            abort(400, 'Ruta de archivo inválida.');
        }

        $publicPath = public_path('uploads/' . $sanitized);
        if (File::exists($publicPath) && File::isFile($publicPath)) {
            return response()->file($publicPath);
        }

        $directPath = public_path($sanitized);
        if (File::exists($directPath) && File::isFile($directPath)) {
            return response()->file($directPath);
        }

        $storagePath = storage_path('app/public/' . $sanitized);
        if (File::exists($storagePath) && File::isFile($storagePath)) {
            return response()->file($storagePath);
        }

        abort(404);
    }
}
