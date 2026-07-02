<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Categoria;

class CategoriaController extends Controller
{
    public function index()
    {
        return response()->json(Categoria::all());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nombre' => 'required|string|unique:categorias',
            'descripcion' => 'nullable|string',
            'icono' => 'nullable|string',
        ]);
        return response()->json(Categoria::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(Categoria::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $cat = Categoria::findOrFail($id);
        $cat->update($request->all());
        return response()->json($cat);
    }

    public function destroy($id)
    {
        Categoria::findOrFail($id)->delete();
        return response()->json(['message' => 'Categoría eliminada']);
    }
}
