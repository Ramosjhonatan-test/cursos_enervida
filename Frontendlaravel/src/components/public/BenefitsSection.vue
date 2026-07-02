<template>
  <section id="impacto" class="py-20 md:py-32 relative overflow-hidden border-y border-on-surface/5">
    <!-- Fondos sutiles de ambiente -->
    <div class="absolute -top-40 -right-40 w-[400px] h-[400px] md:w-[800px] md:h-[800px] bg-accent-neon/10 blur-[80px] md:blur-[160px] rounded-full"></div>
    <div class="absolute -bottom-40 -left-40 w-[400px] h-[400px] md:w-[800px] md:h-[800px] bg-accent-solar/5 blur-[80px] md:blur-[160px] rounded-full"></div>
    
    <div class="w-full max-w-[1400px] mx-auto px-6 relative z-10">
      <!-- Título de Sección -->
      <div class="text-center mb-16 md:mb-24 animate-in fade-in slide-in-from-top duration-1000">
        <span class="text-accent-neon font-black tracking-[0.5em] uppercase text-[10px] mb-6 block opacity-60">Por qué elegirnos</span>
        <h2 class="font-lexend text-4xl md:text-7xl font-black text-on-surface tracking-tighter leading-none ">Tu Futuro <span class="text-gradient-neon ">Sostenible</span> Comienza Aquí</h2>
      </div>
 
       <!-- Rejilla de Beneficios -->
      <div class="grid grid-cols-1 md:grid-cols-12 gap-8 md:gap-12">
        <!-- Beneficio 1: Enfoque Práctico -->
        <div class="md:col-span-8 glass-card rounded-[60px] p-8 md:p-20 flex flex-col justify-end group animate-in fade-in slide-in-from-left duration-1000 delay-300 card-premium-hover border-accent-neon/10 bg-accent-neon/5">
          <div class="mb-10 inline-block p-6 glass-premium rounded-[30px] border-accent-neon/30 shadow-[0_0_40px_rgba(16,255,157,0.2)]">
            <span class="material-symbols-outlined text-6xl md:text-7xl text-accent-neon group-hover:rotate-12 transition-transform duration-700">build_circle</span>
          </div>
          <h3 class="font-lexend text-3xl md:text-5xl text-on-surface font-black mb-6 leading-tight tracking-tighter">Aprendizaje <br/> <span class="text-accent-neon">Altamente Aplicado</span></h3>
          <p class="text-on-surface/70 text-lg md:text-2xl leading-relaxed font-medium max-w-2xl">
            Domina tecnologías clave con proyectos reales. Nuestros laboratorios de vanguardia te preparan para los desafíos energéticos del futuro.
          </p>
        </div>
        
        <!-- Beneficio 2: Impulso Profesional -->
        <div class="md:col-span-4 grid gap-8 md:gap-12">
          <div class="glass-card rounded-[50px] p-10 flex flex-col items-center justify-center text-center group animate-in fade-in slide-in-from-right duration-1000 delay-400 card-premium-hover border-accent-solar/10 bg-accent-solar/5">
            <div class="w-20 h-20 md:w-28 md:h-28 glass-premium rounded-[30px] flex items-center justify-center mb-8 border-accent-solar/30 shadow-[0_0_40px_rgba(234,179,8,0.2)]">
              <span class="material-symbols-outlined text-accent-solar text-5xl md:text-6xl group-hover:scale-110 transition-transform">trending_up</span>
            </div>
            <h4 class="text-on-surface font-black text-lg md:text-xl uppercase tracking-[0.2em] leading-snug font-lexend">Impulso <br/>Profesional</h4>
          </div>
          
          <!-- Beneficio 3: Calidad y Reconocimiento -->
          <div class="glass-card rounded-[50px] p-10 flex flex-col items-center justify-center text-center group animate-in fade-in slide-in-from-right duration-1000 delay-500 card-premium-hover border-accent-neon/10 bg-accent-neon/5">
            <div class="w-20 h-20 md:w-28 md:h-28 glass-premium rounded-[30px] flex items-center justify-center mb-8 border-accent-neon/30 shadow-[0_0_40px_rgba(16,255,157,0.2)]">
              <span class="material-symbols-outlined text-accent-neon text-5xl md:text-6xl group-hover:scale-110 transition-transform">verified</span>
            </div>
            <h4 class="text-on-surface font-black text-lg md:text-xl uppercase tracking-[0.2em] leading-snug font-lexend">Calidad <br/>Global</h4>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
</script>

