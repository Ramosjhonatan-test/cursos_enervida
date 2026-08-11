<template>
  <section id="cursos" class="py-20 md:py-40 relative overflow-hidden">
    <!-- Decoración de fondo -->
    <div class="absolute top-1/4 -right-20 w-96 h-96 bg-primary-container/10 blur-[120px] rounded-full"></div>
    <div class="absolute bottom-1/4 -left-20 w-96 h-96 bg-tertiary-container/10 blur-[120px] rounded-full"></div>

    <div class="w-full max-w-[1400px] mx-auto px-6 relative z-10">
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-8 mb-16 md:mb-24 animate-in slide-in-from-top fade-in duration-1000">
        <div class="max-w-2xl">
          <span class="text-accent-neon font-black tracking-[0.4em] uppercase text-[10px] mb-4 block drop-shadow-sm opacity-60">PROGRAMAS DE CAPACITACIÓN</span>
          <h2 class="font-lexend text-4xl md:text-6xl font-bold text-on-surface leading-tight tracking-tighter">Formación  <br/><span class="text-gradient-neon ">Experta Garantizada</span></h2>
        </div>
        <div class="flex gap-4 md:gap-6">
          <button class="w-14 h-14 md:w-16 md:h-16 rounded-full glass-premium flex items-center justify-center border-on-surface/5 text-on-surface group hover:scale-110 active:scale-95 transition-all shadow-xl">
            <span class="material-symbols-outlined text-2xl group-hover:-translate-x-1 transition-transform">west</span>
          </button>
          <button class="w-14 h-14 md:w-16 md:h-16 rounded-full glass-premium flex items-center justify-center border-on-surface/5 text-on-surface group hover:scale-110 active:scale-95 transition-all shadow-xl">
            <span class="material-symbols-outlined text-2xl group-hover:translate-x-1 transition-transform">east</span>
          </button>
        </div>
      </div>

      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-8 md:gap-12 lg:gap-16">
        <div v-for="(course, index) in courses" :key="index" 
             :class="['group relative animate-in fade-in slide-in-from-bottom duration-1000 cursor-pointer', course.extraClass]"
             :style="{ 'animation-delay': `${index * 150}ms` }"
             @click="navigateTo(course.link)">
          <div :class="['relative h-full min-h-[600px] lg:min-h-[680px] flex flex-col justify-end pb-8 glass-card overflow-hidden group/card transition-all duration-500 border-on-surface/10', course.roundedClass, course.accentHoverClass]">
            <!-- Image Overlay -->
            <div class="absolute inset-0 overflow-hidden">
              <img :alt="course.title" class="w-full h-full object-cover opacity-60 group-hover/card:opacity-80 group-hover/card:scale-105 transition-all duration-1000 ease-out" :src="course.image"/>
              <div class="absolute inset-0 bg-gradient-to-t from-background via-background/60 to-transparent"></div>
            </div>
            
            <div :class="['absolute top-8 right-8 glass-premium rounded-full px-6 py-2.5 text-[10px] md:text-[11px] font-black uppercase tracking-widest border-on-surface/10 shadow-lg z-10', course.accentTextClass]">
              {{ course.duration }}
            </div>

            <div class="relative z-10 p-8 md:p-10 flex flex-col items-start transform group-hover/card:translate-y-[-10px] transition-all duration-500 w-full h-full justify-end">
              <h3 class="font-lexend text-2xl md:text-3xl lg:text-4xl text-on-surface font-black mb-4 md:mb-6 leading-[1.1] tracking-tighter" v-html="course.title"></h3>
              <ul class="text-on-surface/90 text-xs md:text-sm font-medium mb-8 space-y-2.5 w-full">
                <li v-for="(item, idx) in course.items" :key="idx" class="flex items-start gap-2.5">
                   <span class="material-symbols-outlined text-accent-neon text-base mt-0.5 opacity-80 shrink-0">check_circle</span>
                   <span class="leading-tight">{{ item }}</span>
                </li>
              </ul>
              
              <div class="w-full flex items-center justify-between gap-4 mt-auto">
                 <button :class="['btn-premium !px-6 !py-3.5 md:!px-8 md:!py-4 !text-[10px] shadow-lg flex-1', course.btnClass]">
                   Ver Detalles
                 </button>
                 <button class="w-12 h-12 shrink-0 rounded-full glass-premium flex items-center justify-center border-on-surface/10 text-on-surface hover:scale-110 transition-all">
                    <span class="material-symbols-outlined text-sm">arrow_forward</span>
                 </button>
              </div>
              <div :class="['w-16 h-1.5 rounded-full mt-8 group-hover/card:w-full transition-all duration-700 ease-in-out', course.accentBgClass]"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const navigateTo = (link) => {
  if (link) router.push(link)
}

const courses = ref([
  {
    title: 'Para Todos <br/><span class="text-xl md:text-2xl text-accent-neon opacity-90">VIVENCIALES</span>',
    items: [
      'Domingos de familia',
      'Lun-Vie de estudiantes',
      'Sábados de técnicos'
    ],
    duration: 'Presencial',
    image: 'https://ovacen.com/wp-content/uploads/2022/09/energia-solar-fotovoltaica.jpg',
    roundedClass: 'rounded-organic-1',
    accentTextClass: 'text-accent-neon',
    accentBgClass: 'bg-accent-neon',
    accentHoverClass: 'hover-neon-lift',
    btnClass: 'btn-primary-neon',
    extraClass: '', 
    link: '/cursos/vivenciales'
  },
  {
    title: 'Para Todos <br/><span class="text-xl md:text-2xl text-accent-solar opacity-90">ONLINE</span> <br> <span class="text-lg text-accent-oacity-90">ENERGIA SOLAR PARA:</span>' ,
    items: [
      'TODOS',
      'CALOR',
      'ELECTRICIDAD',
      'CONSTRUCCIÓN',
      'PRODUCCIÓN AGROPECUARIA',
      'INDUSTRIA',
      'ILUMINACIÓN PÚBLICA'
    ],
    duration: 'Virtual',
    image: 'https://solarplak.es/energia/imagenes/Caracteristicas-de-las-energias-renovables.jpg',
    roundedClass: 'rounded-premium',
    accentTextClass: 'text-accent-solar',
    accentBgClass: 'bg-accent-solar',
    accentHoverClass: 'hover-solar-lift',
    btnClass: 'btn-primary-solar',
    extraClass: 'md:mt-12',
    link: '/cursos/online'
  },
  {
    title: 'Especializados <br/><span class="text-xl md:text-2xl text-accent-neon opacity-90">PARA TÉCNICOS</span>',
    items: [ 
      'Diseño en PVSyst',
      'Generación Distribuida',
      'Sistemas Aislados',
      'Sistemas Híbridos',
      'Sistemas de bombeo solar',
      'Sistemas Termosolares',
      'Luminarias solares'
    ],
    duration: 'Avanzado',
    image: 'https://www.ipsantotomas.cl/web/wp-content/uploads/sites/27/2023/10/TEC_ENERGIA_SOLAR.jpg',
    roundedClass: 'rounded-organic-2',
    accentTextClass: 'text-accent-neon',
    accentBgClass: 'bg-accent-neon',
    accentHoverClass: 'hover-neon-lift',
    btnClass: 'btn-primary-neon',
    extraClass: '',
    link: '/cursos/tecnicos'
  }
])
</script>
