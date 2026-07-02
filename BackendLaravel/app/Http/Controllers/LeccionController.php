<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Leccion;

class LeccionController extends Controller
{
    public function index()
    {
        return response()->json(Leccion::with('modulo')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'modulo_id' => 'required|exists:modulos,id',
            'titulo' => 'required|string|max:255',
            'orden_leccion' => 'required|integer',
            'tipo_contenido' => 'required|string',
            'video_url' => 'nullable|string',
            'pdf_url' => 'nullable|string',
            'contenido' => 'nullable|string',
            'duracion_minutos' => 'nullable|integer',
            'es_preview' => 'boolean',
        ]);

        $leccion = Leccion::create($data);
        return response()->json($leccion, 201);
    }

    public function show($id)
    {
        return response()->json(Leccion::with('modulo.curso')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $leccion = Leccion::findOrFail($id);
        $leccion->update($request->all());
        return response()->json($leccion);
    }

    public function destroy($id)
    {
        $leccion = Leccion::findOrFail($id);
        $leccion->delete();
        return response()->json(['message' => 'Lección eliminada']);
    }
}
