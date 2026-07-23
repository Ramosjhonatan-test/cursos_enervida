<!DOCTYPE html>
<html>
<head>
    <title>{{ $titulo }}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; padding: 40px 20px; margin: 0; -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;">
    <table width="100%" cellpadding="0" cellspacing="0" role="presentation" style="background-color: #f8fafc; width: 100%; margin: 0; padding: 0;">
        <tr>
            <td align="center">
                <table width="100%" max-width="580" cellpadding="0" cellspacing="0" role="presentation" style="max-width: 580px; width: 100%; margin: 0 auto; background-color: #ffffff; border-radius: 20px; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03); overflow: hidden;">
                    <!-- Top Icon Header -->
                    <tr>
                        <td align="center" style="padding: 40px 40px 20px;">
                            @if(isset($tipo) && $tipo === 'critical')
                                <!-- Critical Icon Circle (Red Lock / Shield) -->
                                <div style="display: inline-block; background-color: #fee2e2; width: 64px; height: 64px; border-radius: 50%; text-align: center; vertical-align: middle;">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#ef4444" width="32" height="32" style="margin-top: 16px; display: inline-block;">
                                        <path fill-rule="evenodd" d="M12 1.5a5.25 5.25 0 0 0-5.25 5.25v3a3 3 0 0 0-3 3v6.75a3 3 0 0 0 3 3h10.5a3 3 0 0 0 3-3v-6.75a3 3 0 0 0-3-3v-3c0-2.9-2.35-5.25-5.25-5.25Zm3.75 8.25v-3a3.75 3.75 0 1 0-7.5 0v3h7.5Z" clip-rule="evenodd" />
                                    </svg>
                                </div>
                            @else
                                <!-- Normal Icon Circle (Teal Key) -->
                                <div style="display: inline-block; background-color: #ccfbf1; width: 64px; height: 64px; border-radius: 50%; text-align: center; vertical-align: middle;">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#0ea5a4" width="32" height="32" style="margin-top: 16px; display: inline-block;">
                                        <path d="M18 1.5a5.25 5.25 0 0 0-5.25 5.25v.75H12a5.25 5.25 0 0 0-5.25 5.25v5.25a3 3 0 0 0 3 3h10.5a3 3 0 0 0 3-3V12a5.25 5.25 0 0 0-5.25-5.25h-.75V6.75A5.25 5.25 0 0 0 18 1.5ZM14.25 7.5v-.75a3.75 3.75 0 1 1 7.5 0v.75h-7.5ZM12 11.25a2.25 2.25 0 1 0 0 4.5 2.25 2.25 0 0 0 0-4.5Z" />
                                    </svg>
                                </div>
                            @endif
                        </td>
                    </tr>

                    <!-- Title -->
                    <tr>
                        <td align="center" style="padding: 0 40px 24px;">
                            <h2 style="margin: 0; font-size: 24px; font-weight: 800; color: #1e293b; letter-spacing: -0.02em;">{{ $titulo }}</h2>
                        </td>
                    </tr>

                    <!-- Main Content -->
                    <tr>
                        <td style="padding: 0 40px 30px; text-align: left;">
                            <p style="margin: 0 0 16px; font-size: 16px; line-height: 24px; color: #334155;">
                                Hola <strong style="color: #0f172a;">{{ $usuario ? ($usuario->nombres) : 'Usuario' }}</strong>,
                            </p>
                            <p style="margin: 0 0 24px; font-size: 15px; line-height: 24px; color: #475569;">
                                {{ $mensaje }}
                            </p>

                            <!-- Alert Box -->
                            <table width="100%" cellpadding="0" cellspacing="0" role="presentation" style="width: 100%; border-collapse: collapse; margin-bottom: 24px; border-radius: 12px; overflow: hidden;">
                                <tr>
                                    @if(isset($tipo) && $tipo === 'critical')
                                        <!-- Critical Lockout Alert Box -->
                                        <td style="background-color: #fef2f2; border-left: 4px solid #ef4444; padding: 18px 20px;">
                                            <h4 style="margin: 0 0 6px 0; font-size: 14px; font-weight: 700; color: #991b1b;">¿Qué significa esto?</h4>
                                            <p style="margin: 0; font-size: 14px; line-height: 20px; color: #b91c1c;">
                                                Nadie puede entrar a tu cuenta en este momento, incluso con la contraseña correcta, hasta que un administrador revise el caso.
                                            </p>
                                        </td>
                                    @else
                                        <!-- Normal Reset Alert Box -->
                                        <td style="background-color: #f0fdfa; border-left: 4px solid #0ea5a4; padding: 18px 20px;">
                                            <h4 style="margin: 0 0 6px 0; font-size: 14px; font-weight: 700; color: #115e59;">¿Qué debes hacer?</h4>
                                            <p style="margin: 0; font-size: 14px; line-height: 20px; color: #134e4a;">
                                                Haz clic en el botón de abajo para restablecer tu contraseña. Por seguridad, este enlace tiene una validez de 1 hora.
                                            </p>
                                        </td>
                                    @endif
                                </tr>
                            </table>

                            <!-- CTA Button -->
                            @if(!empty($botonTexto) && !empty($botonUrl))
                                <table width="100%" cellpadding="0" cellspacing="0" role="presentation" style="margin: 28px 0; text-align: center;">
                                    <tr>
                                        <td align="center">
                                            @if(isset($tipo) && $tipo === 'critical')
                                                <a href="{{ $botonUrl }}" style="display: inline-block; background-color: #df1515ff; color: #ffffff; text-decoration: none; padding: 14px 32px; border-radius: 9999px; font-weight: 700; font-size: 15px; box-shadow: 0 4px 6px -1px rgba(239, 68, 68, 0.2), 0 2px 4px -1px rgba(239, 68, 68, 0.1); transition: background-color 0.2s;">
                                                    {{ $botonTexto }}
                                                </a>
                                            @else
                                                <a href="{{ $botonUrl }}" style="display: inline-block; background-color: #ab3b0bff; color: #ffffff; text-decoration: none; padding: 14px 32px; border-radius: 9999px; font-weight: 700; font-size: 15px; box-shadow: 0 4px 6px -1px rgba(14, 165, 164, 0.2), 0 2px 4px -1px rgba(14, 165, 164, 0.1); transition: background-color 0.2s;">
                                                    {{ $botonTexto }}
                                                </a>
                                            @endif
                                        </td>
                                    </tr>
                                </table>
                            @endif

                            <!-- Extra Footer Note -->
                            <p style="margin: 24px 0 0; font-size: 13px; line-height: 18px; color: #64748b;">
                                @if(isset($tipo) && $tipo === 'critical')
                                    Si no fuiste tú quien intentó acceder, es posible que alguien conozca tu correo. Te recomendamos contactar a soporte para restaurar tu acceso.
                                @else
                                    Si no solicitaste este cambio, puedes ignorar este correo de forma segura. Tu contraseña actual no se modificará.
                                @endif
                            </p>
                        </td>
                    </tr>

                    <!-- System Footer -->
                    <tr>
                        <td align="center" style="background-color: #f8fafc; border-top: 1px solid #f1f5f9; padding: 24px 40px 32px; text-align: center;">
                            <p style="margin: 0 0 6px; font-size: 12px; font-weight: 700; color: #64748b; letter-spacing: 0.05em; text-transform: uppercase;">
                                Mensaje automático de <span style="color: #0ea5a4;">Enervida LMS</span>
                            </p>
                            <p style="margin: 0; font-size: 12px; line-height: 16px; color: #94a3b8;">
                                Por favor no respondas a este correo. Si necesitas ayuda, ponte en contacto con soporte.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
