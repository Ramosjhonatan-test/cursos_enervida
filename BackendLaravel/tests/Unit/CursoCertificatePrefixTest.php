<?php

namespace Tests\Unit;

use App\Models\Curso;
use PHPUnit\Framework\TestCase;

class CursoCertificatePrefixTest extends TestCase
{
    public function test_derives_prefix_from_slug_when_words_are_present()
    {
        $curso = new Curso([
            'slug' => 'maquetacion-y-construccion-de-bombos',
        ]);

        $this->assertSame('MCB', $curso->obtenerPrefijoCertificado());
    }

    public function test_derives_prefix_from_slug_when_single_word_is_present()
    {
        $curso = new Curso([
            'slug' => 'lombricultura',
        ]);

        $this->assertSame('LOM', $curso->obtenerPrefijoCertificado());
    }
}
