<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Rol;

class RolController extends Controller
{
    public function index()
    {
        return response()->json(Rol::all());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nombre' => 'required|string|unique:roles',
            'descripcion' => 'nullable|string',
        ]);
        return response()->json(Rol::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(Rol::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $rol = Rol::findOrFail($id);
        $rol->update($request->all());
        return response()->json($rol);
    }

    public function destroy($id)
    {
        Rol::findOrFail($id)->delete();
        return response()->json(['message' => 'Rol eliminado']);
    }
}
