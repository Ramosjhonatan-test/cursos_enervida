<template>
  <section id="nosotros" class="py-20 md:py-40 px-4 md:px-6 relative overflow-hidden">
    <div class="max-w-6xl mx-auto glass-card rounded-[40px] md:rounded-[80px] relative overflow-hidden p-12 md:p-32 text-center border-accent-neon/20 shadow-2xl animate-in fade-in slide-in-from-bottom duration-1000">
      <!-- Background Effects -->
      <div class="absolute inset-0 bg-gradient-to-br from-accent-neon/10 via-transparent to-accent-solar/10 opacity-30"></div>
      <div class="absolute -top-40 -left-40 w-96 h-96 bg-accent-neon/20 blur-[120px] rounded-full animate-pulse"></div>
      <div class="absolute -bottom-40 -right-40 w-96 h-96 bg-accent-solar/10 blur-[120px] rounded-full"></div>
      
      <div class="relative z-10">
        <span class="text-accent-neon font-black tracking-[0.5em] uppercase text-[10px] mb-8 block drop-shadow-sm">Próximo paso</span>
        <h2 class="font-lexend text-4xl md:text-8xl text-on-surface font-black mb-10 leading-none tracking-tighter">
          ¿Listo para <br/>
          <span class="text-gradient-neon  drop-shadow-2xl">Liderar el Cambio?</span>
        </h2>
        <p class="text-on-surface/70 text-lg md:text-2xl max-w-2xl mx-auto mb-16 font-medium leading-relaxed">
          Únete a la red más exclusiva de profesionales en energías renovables. Tu futuro sostenible comienza hoy.
        </p>
        <div class="flex flex-col sm:flex-row justify-center items-center gap-8 md:gap-12">
          <button @click="$router.push('/login')" class="btn-premium btn-primary-neon !px-16 !py-6 !text-lg shadow-[0_20px_50px_rgba(16,255,157,0.3)] hover:scale-110 active:scale-95 transition-all">
            Empieza Ahora
          </button>
          <button class="flex items-center gap-4 text-on-surface font-black uppercase tracking-[0.3em] text-[11px] hover:text-accent-neon transition-all group/btn">
            Ver Programa
            <span class="material-symbols-outlined group-hover/btn:translate-x-2 transition-transform">arrow_forward</span>
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

