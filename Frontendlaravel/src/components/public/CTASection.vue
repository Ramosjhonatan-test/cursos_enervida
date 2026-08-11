<template>
  <section id="nosotros" class="py-24 md:py-36 px-4 md:px-6 relative overflow-hidden bg-background">
    <!-- Fondos Animados Decorativos -->
    <div class="absolute inset-0 z-0 overflow-hidden pointer-events-none">
      <div class="absolute top-1/4 -left-[10%] w-[600px] h-[600px] bg-accent-neon/5 rounded-full blur-[140px] animate-pulse-slow"></div>
      <div class="absolute bottom-1/4 -right-[10%] w-[600px] h-[600px] bg-accent-solar/5 rounded-full blur-[140px] animate-pulse-slow delay-1000"></div>
    </div>

    <div class="max-w-7xl mx-auto relative z-10">
      
      <!-- Encabezado de la Sección -->
      <div class="text-center max-w-3xl mx-auto mb-16 md:mb-24">
        <span class="text-accent-neon font-black tracking-[0.4em] uppercase text-[10px] mb-4 block">Sobre Nosotros</span>
        <h2 class="font-lexend text-4xl md:text-6xl text-on-surface font-black tracking-tight mb-6">
          Energía, desarrollo y <span class="text-gradient-neon">compromiso social</span>
        </h2>
        <p class="text-on-surface-variant text-base md:t ext-lg font-medium leading-relaxed">
          Conoce quiénes somos, nuestra trayectoria internacional y los valores fundamentales que impulsan cada uno de nuestros proyectos.
        </p>
      </div>

      <!-- Grid Principal (Bento Layout) -->
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">

        <!-- 1. Misión y Visión (Ocupan la parte superior / columnas principales) -->
        <div class="lg:col-span-6 glass-card p-8 md:p-12 rounded-[2.5rem] flex flex-col justify-between relative overflow-hidden border border-on-surface/[0.05]">
          <div class="absolute top-0 right-0 w-40 h-40 bg-accent-neon/10 rounded-full blur-3xl pointer-events-none"></div>
          <div>
            <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-accent-neon/10 text-accent-neon text-xs font-black tracking-wider uppercase mb-6">
              <span class="w-2 h-2 rounded-full bg-accent-neon animate-pulse"></span>
              Nuestra Misión
            </div>
            <p class="text-on-surface text-base md:text-lg leading-relaxed font-normal">
              ENERVIDA es una institución de carácter privado comprometida con la mejora de las condiciones de vida de hombres, mujeres, jóvenes, niños y mascotas en situación de calle. Tiene la misión de <strong class="font-bold text-on-surface">acelerar el proceso de adopción de tecnologías</strong> para el acceso y uso eficiente de la energía y el agua en el país.
            </p>
          </div>
        </div>

        <div class="lg:col-span-6 glass-card p-8 md:p-12 rounded-[2.5rem] flex flex-col justify-between relative overflow-hidden border border-on-surface/[0.05]">
          <div class="absolute top-0 right-0 w-40 h-40 bg-accent-solar/10 rounded-full blur-3xl pointer-events-none"></div>
          <div>
            <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-accent-solar/10 text-accent-solar text-xs font-black tracking-wider uppercase mb-6">
              <span class="w-2 h-2 rounded-full bg-accent-solar animate-pulse"></span>
              Nuestra Visión
            </div>
            <p class="text-on-surface text-base md:text-lg leading-relaxed font-normal">
              La visión de ENERVIDA es que cada rincón de Bolivia y del mundo cuente con <strong class="font-bold text-on-surface">acceso a energía y agua</strong>, y que lo utilice de manera responsable para el bienestar de la sociedad y la estabilidad de los ecosistemas en general, de hoy y mañana.
            </p>
          </div>
        </div>

        <!-- 2. Experiencia y Red Colectiva (Ancho completo) -->
        <div class="lg:col-span-12 glass-card p-8 md:p-12 rounded-[2.5rem] relative overflow-hidden border border-on-surface/[0.05]">
          <div class="max-w-4xl">
            <span class="text-accent-neon font-black tracking-[0.3em] uppercase text-[10px] mb-3 block">Trayectoria & Alcance</span>
            <h3 class="font-lexend text-2xl md:text-4xl font-black text-on-surface mb-6">Red de Conocimiento Colectivo para América y el Mundo</h3>
            <p class="text-on-surface-variant text-base md:text-lg leading-relaxed font-medium mb-6">
              Fundada en Cochabamba, Bolivia, y con sede actual en La Paz, ENERVIDA cuenta con un alcance geográfico internacional. Nos respaldamos en una modesta red de profesionales cuya meta es contribuir al desarrollo de la comunidad rural, urbana y periurbana de Latinoamérica sin límites geográficos, constituyéndonos en un referente de conocimiento colectivo.
            </p>
          </div>
        </div>

        <!-- 3. Principales Actividades (4 columnas o grid interno) -->
        <div class="lg:col-span-7 glass-card p-8 md:p-10 rounded-[2.5rem] border border-on-surface/[0.05] flex flex-col justify-between">
          <div>
            <span class="text-accent-neon font-black tracking-[0.3em] uppercase text-[10px] mb-3 block">Capacidades Operativas</span>
            <h3 class="font-lexend text-2xl font-black text-on-surface mb-6">Nuestras Actividades</h3>
            <ul class="space-y-4">
              <li class="flex items-start gap-3">
                <span class="mt-1 flex-shrink-0 w-5 h-5 rounded-full bg-accent-neon/20 text-accent-neon flex items-center justify-center text-xs font-black">✓</span>
                <span class="text-on-surface-variant text-sm font-medium leading-relaxed">Servicios profesionales de consultoría para la planificación, implementación y evaluación de proyectos energéticos y productivos.</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="mt-1 flex-shrink-0 w-5 h-5 rounded-full bg-accent-neon/20 text-accent-neon flex items-center justify-center text-xs font-black">✓</span>
                <span class="text-on-surface-variant text-sm font-medium leading-relaxed">Comercialización, importación, exportación y provisión de tecnologías productivas y energéticas con base en fuentes renovables y convencionales.</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="mt-1 flex-shrink-0 w-5 h-5 rounded-full bg-accent-neon/20 text-accent-neon flex items-center justify-center text-xs font-black">✓</span>
                <span class="text-on-surface-variant text-sm font-medium leading-relaxed">Servicios de capacitación en áreas sociales, económicas, ambientales, técnicas y energéticas.</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="mt-1 flex-shrink-0 w-5 h-5 rounded-full bg-accent-neon/20 text-accent-neon flex items-center justify-center text-xs font-black">✓</span>
                <span class="text-on-surface-variant text-sm font-medium leading-relaxed">Promoción de la eficiencia energética, bombeo de agua, riego tecnificado, TICs, emprendedurismo, derechos de la niñez e inclusión de género y juventud.</span>
              </li>
            </ul>
          </div>
        </div>

        <!-- 4. Valores Fundamentales y 5 Áreas de Impacto Social / Animal -->
        <div class="lg:col-span-5 glass-card p-8 md:p-10 rounded-[2.5rem] border border-on-surface/[0.05] flex flex-col justify-between bg-gradient-to-br from-accent-neon/[0.02] to-accent-solar/[0.02]">
          <div>
            <span class="text-accent-solar font-black tracking-[0.3em] uppercase text-[10px] mb-3 block">Impacto y Responsabilidad</span>
            <h3 class="font-lexend text-2xl font-black text-on-surface mb-4">Áreas de Trabajo Social y Ambiental</h3>
            <p class="text-on-surface-variant text-sm mb-6 leading-relaxed">
              Valoramos profundamente el equilibrio del ecosistema y el bienestar de los animales domésticos y silvestres en peligro. Gestionamos y destinamos recursos a través de 5 programas clave:
            </p>
            
            <div class="space-y-3">
              <div class="flex items-center gap-3 p-3 rounded-xl bg-on-surface/[0.03] border border-on-surface/[0.04]">
                <div class="w-2 h-2 rounded-full bg-accent-solar"></div>
                <span class="text-xs font-bold text-on-surface uppercase tracking-wide">Mujeres libres de violencia</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-on-surface/[0.03] border border-on-surface/[0.04]">
                <div class="w-2 h-2 rounded-full bg-accent-solar"></div>
                <span class="text-xs font-bold text-on-surface uppercase tracking-wide">Niños y jóvenes ejerciendo sus derechos</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-on-surface/[0.03] border border-on-surface/[0.04]">
                <div class="w-2 h-2 rounded-full bg-accent-solar"></div>
                <span class="text-xs font-bold text-on-surface uppercase tracking-wide">Calles libres de animales abandonados</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-on-surface/[0.03] border border-on-surface/[0.04]">
                <div class="w-2 h-2 rounded-full bg-accent-solar"></div>
                <span class="text-xs font-bold text-on-surface uppercase tracking-wide">Inserción de jóvenes al ámbito laboral</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-on-surface/[0.03] border border-on-surface/[0.04]">
                <div class="w-2 h-2 rounded-full bg-accent-solar"></div>
                <span class="text-xs font-bold text-on-surface uppercase tracking-wide">Protección del medio ambiente</span>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>
  </section>
</template>

<style scoped>
@keyframes pulse-slow {
  0%, 100% { opacity: 0.1; transform: scale(1); }
  50% { opacity: 0.2; transform: scale(1.05); }
}

.animate-pulse-slow {
  animation: pulse-slow 8s ease-in-out infinite;
}
</style>