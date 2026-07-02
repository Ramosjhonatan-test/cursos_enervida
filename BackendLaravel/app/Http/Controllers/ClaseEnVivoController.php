<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ClaseEnVivo;

class ClaseEnVivoController extends Controller
{
    public function index()
    {
        return response()->json(ClaseEnVivo::with('curso')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id',
            'titulo' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'url_reunion' => 'nullable|string',
            'fecha_inicio' => 'required',
            'duracion_minutos' => 'nullable|integer',
            'estado' => 'nullable|string',
        ]);
        return response()->json(ClaseEnVivo::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(ClaseEnVivo::with(['curso', 'participantes'])->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $clase = ClaseEnVivo::findOrFail($id);
        $clase->update($request->all());
        return response()->json($clase);
    }

    public function destroy($id)
    {
        ClaseEnVivo::findOrFail($id)->delete();
        return response()->json(['message' => 'Clase en vivo eliminada']);
    }
}
