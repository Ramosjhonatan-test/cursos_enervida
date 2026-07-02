<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Modulo;

class ModuloController extends Controller
{
    public function index()
    {
        return response()->json(Modulo::with('lecciones')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'curso_id' => 'required|exists:cursos,id',
            'titulo' => 'required|string|max:255',
            'orden_modulo' => 'required|integer',
        ]);
        return response()->json(Modulo::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(Modulo::with('lecciones')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $modulo = Modulo::findOrFail($id);
        $modulo->update($request->all());
        return response()->json($modulo);
    }

    public function destroy($id)
    {
        Modulo::findOrFail($id)->delete();
        return response()->json(['message' => 'Módulo eliminado']);
    }
}
