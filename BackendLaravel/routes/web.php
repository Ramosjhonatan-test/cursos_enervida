<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\File;

Route::get('/', function () {
    return view('welcome');
});

/**
 * Sirve archivos del storage sin necesitar el symlink storage:link.
 * Esto permite que las imágenes/PDFs subidos con la ruta antigua (/storage/...)
 * funcionen en Hostinger y cualquier hosting sin soporte de symlinks.
 */
Route::get('/storage/{path}', function (string $path) {
    $fullPath = storage_path('app/public/' . $path);

    if (!File::exists($fullPath)) {
        abort(404);
    }

    $mimeType = File::mimeType($fullPath);
    return response()->file($fullPath, ['Content-Type' => $mimeType]);
})->where('path', '.*');
