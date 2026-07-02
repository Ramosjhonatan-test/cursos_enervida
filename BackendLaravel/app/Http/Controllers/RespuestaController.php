<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Respuesta;

class RespuestaController extends Controller
{
    public function index()
    {
        return response()->json(Respuesta::all());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'pregunta_id' => 'required|exists:preguntas,id',
            'respuesta' => 'required|string',
            'es_correcta' => 'required|boolean',
        ]);
        return response()->json(Respuesta::create($data), 201);
    }

    public function show($id)
    {
        return response()->json(Respuesta::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $respuesta = Respuesta::findOrFail($id);
        $respuesta->update($request->all());
        return response()->json($respuesta);
    }

    public function destroy($id)
    {
        Respuesta::findOrFail($id)->delete();
        return response()->json(['message' => 'Respuesta eliminada']);
    }
}
