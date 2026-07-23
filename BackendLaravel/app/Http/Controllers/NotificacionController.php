<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Notificacion;

class NotificacionController extends Controller
{
    public function index()
    {
        return response()->json(Notificacion::all());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'usuario_id' => 'required|exists:usuarios,id',
            'titulo' => 'required|string|max:255',
            'mensaje' => 'required|string',
            'tipo' => 'nullable|string',
            'leida' => 'boolean',
        ]);
        
        $notificacion = Notificacion::create($data);
        
        // Intentar enviar el correo (en caso de fallar, no rompe la API)
        try {
            $usuario = \App\Models\Usuario::find($data['usuario_id']);
            if ($usuario && $usuario->correo) {
                \Illuminate\Support\Facades\Mail::to($usuario->correo)->send(
                    new \App\Mail\NotificacionMailable(
                        $data['titulo'],
                        $data['mensaje'],
                        null,
                        null,
                        $data['tipo'] ?? 'normal',
                        $usuario
                    )
                );
            }
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Error al enviar email de notificación: ' . $e->getMessage());
        }
        
        return response()->json($notificacion, 201);
    }

    public function show($id)
    {
        return response()->json(Notificacion::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $notif = Notificacion::findOrFail($id);
        $notif->update($request->all());
        return response()->json($notif);
    }

    public function destroy($id)
    {
        Notificacion::findOrFail($id)->delete();
        return response()->json(['message' => 'Notificación eliminada']);
    }
}
