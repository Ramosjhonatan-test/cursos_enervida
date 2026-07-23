<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class NotificacionMailable extends Mailable
{
    use Queueable, SerializesModels;

    public $titulo;
    public $mensaje;
    public $botonTexto;
    public $botonUrl;
    public $tipo;
    public $usuario;
    

    /**
     * Create a new message instance.
     */
    public function __construct($titulo, $mensaje, $botonTexto = null, $botonUrl = null, $tipo = 'normal', $usuario = null)
    {
        $this->titulo = $titulo;
        $this->mensaje = $mensaje;
        $this->botonTexto = $botonTexto;
        $this->botonUrl = $botonUrl;
        $this->tipo = $tipo;
        $this->usuario = $usuario;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: $this->titulo,
        );
    }

    /**
     * Build the message.
     */
    public function build(): self
    {
        return $this->view('emails.notificacion')
                    ->text('emails.notificacion_text');
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}

