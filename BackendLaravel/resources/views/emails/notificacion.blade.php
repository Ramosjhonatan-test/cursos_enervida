<!DOCTYPE html>
<html>
<head>
    <title>{{ $titulo }}</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <h2 style="color: #1a237e; border-bottom: 2px solid #eeeeee; padding-bottom: 10px;">{{ $titulo }}</h2>
        <div style="color: #333333; line-height: 1.6; margin-top: 20px; white-space: pre-line;">
            {{ $mensaje }}
        </div>
        <div style="margin-top: 40px; border-top: 1px solid #eeeeee; padding-top: 20px; font-size: 12px; color: #888888; text-align: center;">
            <p>Este es un mensaje automático de la plataforma Enervida LMS.</p>
        </div>
    </div>
</body>
</html>
