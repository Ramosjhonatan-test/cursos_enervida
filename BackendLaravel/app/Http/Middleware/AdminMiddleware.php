<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $user = auth('api')->user();

        if (!$user || !$user->rol || $user->rol->nombre !== 'admin') {
            return response()->json([
                'error' => 'NO_AUTORIZADO',
                'message' => 'Acceso denegado. Se requieren privilegios de administrador.'
            ], 403);
        }

        return $next($request);
    }
}
