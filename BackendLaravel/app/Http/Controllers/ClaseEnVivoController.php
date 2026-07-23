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
            'sala_jitsi' => 'required|string|max:255',
            'creado_por' => 'required|exists:usuarios,id',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'nullable|date',
        ]);

        return response()->json(ClaseEnVivo::create($data), 201);
    }

    public function update(Request $request, $id)
    {
        $clase = ClaseEnVivo::findOrFail($id);

        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id',
            'titulo' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'sala_jitsi' => 'required|string|max:255',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'nullable|date',
        ]);

        $clase->update($data);
        return response()->json($clase);
    }

    public function show($id)
    {
        return response()->json(ClaseEnVivo::with(['curso', 'participantes'])->findOrFail($id));
    }

    public function destroy($id)
    {
        ClaseEnVivo::findOrFail($id)->delete();
        return response()->json(['message' => 'Clase en vivo eliminada']);
    }
}
