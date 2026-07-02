<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Vista Previa del Certificado</title>
    <style>
        @page {
            size: {{ $width }}pt {{ $height }}pt;
            margin: 0;
        }
        html, body {
            margin: 0;
            padding: 0;
            width: {{ $width }}pt;
            height: {{ $height }}pt;
            position: relative;
            background-color: #ffffff;
            font-family: 'Helvetica', 'Arial', sans-serif;
            overflow: hidden;
        }
        .background-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }
        .element {
            position: absolute;
            box-sizing: border-box;
        }
        .text-element {
            line-height: 1.3;
        }
    </style>
</head>
<body>
    @if(!empty($background_url))
        <img class="background-image" src="{{ $background_url }}" />
    @endif

    @foreach($elements as $el)
        @if(($el['hidden'] ?? false) == false)
            <div class="element {{ $el['type'] }}-element" style="
                left: {{ $el['x'] ?? 0 }}pt;
                top: {{ $el['y'] ?? 0 }}pt;
                width: {{ $el['width'] ?? 100 }}pt;
                @if($el['type'] !== 'text') 
                    height: {{ $el['height'] ?? 100 }}pt; 
                @endif
                @if($el['type'] === 'text')
                    font-size: {{ $el['size'] ?? 16 }}pt;
                    color: {{ $el['color'] ?? '#000000' }};
                    font-family: {{ $el['fontFamily'] ?? 'Helvetica' }}, sans-serif;
                    font-weight: {{ ($el['bold'] ?? false) ? 'bold' : 'normal' }};
                    font-style: {{ ($el['italic'] ?? false) ? 'italic' : 'normal' }};
                    text-align: {{ $el['textAlign'] ?? 'left' }};
                    @if(isset($el['letterSpacing']) && $el['letterSpacing'] > 0)
                        letter-spacing: {{ $el['letterSpacing'] }}pt;
                    @endif
                @endif
                @if(isset($el['opacity'])) 
                    opacity: {{ $el['opacity'] / 100 }}; 
                @endif
                @if(isset($el['rotate']) && $el['rotate'] != 0) 
                    transform: rotate({{ $el['rotate'] }}deg); 
                @endif
            ">
                @if($el['type'] === 'text')
                    {!! nl2br(e($el['rendered_content'] ?? '')) !!}
                @elseif($el['type'] === 'image' && !empty($el['full_url']))
                    <img src="{{ $el['full_url'] }}" style="width: 100%; height: 100%; object-fit: contain; display: block;" />
                @elseif($el['type'] === 'qr')
                    @if(isset($el['qr_code_base64']))
                        <img src="data:image/svg+xml;base64,{{ $el['qr_code_base64'] }}" style="width: 100%; height: 100%; display: block;" />
                    @else
                        <div style="width: 100%; height: 100%; border: 2px solid #000; background: #fff; padding: 4px; box-sizing: border-box; text-align: center;">
                            <!-- Simple visual placeholder representing a QR code -->
                            <div style="width: 100%; height: 100%; background: #000; color: #fff; font-size: 8pt; font-weight: bold; line-height: 1.1; display: table;">
                                <span style="display: table-cell; vertical-align: middle;">QR VALIDACIÓN</span>
                            </div>
                        </div>
                    @endif
                @endif
            </div>
        @endif
    @endforeach
</body>
</html>
