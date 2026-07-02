<!DOCTYPE html>
<html>
<head>
    <title>Certificado de Finalización</title>
    <style>
        body { font-family: sans-serif; text-align: center; margin-top: 50px; }
        .title { font-size: 40px; font-weight: bold; margin-bottom: 20px; }
        .subtitle { font-size: 20px; color: #555; }
        .name { font-size: 35px; margin: 30px 0; text-transform: uppercase; color: #2c3e50; }
        .course { font-size: 25px; font-weight: bold; margin: 20px 0; }
        .footer { margin-top: 50px; font-size: 14px; color: #777; }
    </style>
</head>
<body>
    <div class="title">Certificado de Finalización</div>
    <div class="subtitle">Este certificado es otorgado a:</div>
    <div class="name">{{ $nombres }} {{ $apellidos }}</div>
    <div class="subtitle">Por haber completado exitosamente el curso:</div>
    <div class="course">{{ $curso }}</div>
    
    <div class="footer">
        Fecha de Emisión: {{ $fecha }}<br>
        Código de Verificación: {{ $codigo }}
    </div>
</body>
</html>
