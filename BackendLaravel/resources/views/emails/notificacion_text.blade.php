@php
    function wrap($text, $width = 72) {
        return wordwrap($text, $width, "\n");
    }
@endphp

@if(isset($tipo) && $tipo === 'critical')
CUENTA BLOQUEADA POR SEGURIDAD
----------------------------------------
@else
RECUPERACION DE CONTRASENA - ENERVIDA LMS
----------------------------------------
@endif

Hola {{ strtoupper($usuario->nombres ?? 'USUARIO') }},

{{ wrap($mensaje) }}

¿Qué significa esto?
----------------------------------------
@if(isset($tipo) && $tipo === 'critical')
{{ wrap('Nadie puede entrar a tu cuenta en este momento, incluso con la contraseña correcta, hasta que un administrador revise el caso.') }}
@else
{{ wrap('Si solicitaste restablecer tu contraseña, usa el enlace indicado abajo. El enlace expira en 1 hora.') }}
@endif

@if(!empty($botonTexto) && !empty($botonUrl))
{{ $botonTexto }}
{{ $botonUrl }}
@endif

----------------------------------------
Este es un mensaje automático de Enervida LMS.
Si no solicitaste este correo, ignóralo con seguridad.
