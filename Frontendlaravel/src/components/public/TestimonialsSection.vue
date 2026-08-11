<template>
  <section id="socios" class="py-20 md:py-40 relative overflow-hidden">
    
    <!-- Elementos de brillo de fondo ambiental -->
    <div class="absolute top-1/3 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-accent-neon/5 rounded-full blur-[140px] pointer-events-none"></div>

    <div class="w-full max-w-[1400px] mx-auto px-6 relative z-10">
      
      <!-- Encabezado -->
      <div class="text-center mb-16 md:mb-24 animate-in fade-in slide-in-from-top duration-1000">
        <span class="text-accent-neon font-black tracking-[0.5em] uppercase text-[10px] mb-4 block">Red de Colaboración Institucional</span>
        <h2 class="font-lexend text-4xl md:text-5xl font-black text-on-surface">Nuestros <span class="text-gradient-neon not-italic">Aliados</span></h2>
      </div>

      <!-- Grid de Socios y Aliados -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 md:gap-12">
        
        <div v-for="(partner, index) in partners" :key="index"
             :class="['glass-premium p-8 md:p-14 relative group/card transition-all duration-500 hover:-translate-y-2 flex flex-col justify-between', partner.roundedClass, partner.extraClass, partner.borderClass, 'animate-in fade-in slide-in-from-bottom duration-700 shadow-xl hover:shadow-[0_20px_60px_rgba(0,0,0,0.15)]']"
             :style="{ 'animation-delay': `${index * 150}ms` }">
          
          <!-- Ícono de Comilla / Detalle Decorativo de Fondo -->
          <span :class="['text-8xl md:text-9xl absolute -top-6 -left-6 md:-top-8 md:-left-8 opacity-10 font-serif transition-all duration-500 group-hover/card:opacity-20 group-hover/card:scale-110 pointer-events-none', partner.iconClass]">“</span>
          
          <!-- Contenedor Superior: Imagen y Descripción -->
          <div class="relative z-10">
            <!-- Logo del Aliado -->
            <div v-if="partner.image" class="mb-6 h-12 flex items-center">
              <img :src="partner.image" :alt="partner.name" class="max-h-full max-w-[150px] object-contain" />
            </div>

            <!-- Descripción del Aliado -->
            <p class="text-on-surface/80 mb-8 md:mb-12 leading-relaxed text-lg font-light">
              "{{ partner.description }}"
            </p>
          </div>
          
          <!-- Parte Inferior: Nombre y Redes Sociales -->
          <div class="relative z-10 mt-auto pt-6 border-t border-on-surface/5">
            <h5 class="font-black text-on-surface text-xl leading-tight mb-4">{{ partner.name }}</h5>
            
            <!-- Contenedor de Botones de Redes Sociales (Siempre con color) -->
            <div class="flex flex-wrap items-center gap-2.5">
              <a v-for="(social, sIdx) in partner.socials" :key="sIdx"
                 :href="social.url" target="_blank" rel="noopener noreferrer"
                 :class="['w-10 h-10 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-permanent group', social.extraClass || '']"
                 :style="{ '--brand': social.color, color: social.color }"
                 :title="social.name">
                <svg class="w-4 h-4 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24" v-html="social.svgPath"></svg>
              </a>
            </div>
          </div>

        </div>

      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const partners = ref([
  {
    name: 'FASERTe',
    description: 'Dinamizan el mercado de tecnologías con energía renovable y eficientes.',
    image: '/socios/FASERTE.png',
    roundedClass: 'rounded-organic-1',
    iconClass: 'icon-gradient',
    extraClass: '',
    borderClass: '',
    socials: [
      {
        name: 'Facebook',
        color: '#1877F2',
        url: 'https://www.facebook.com/FASERTE.Bolivia/',
        svgPath: '<path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.469h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.469h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>'
      },
      {
        name: 'Sitio Web',
        color: '#10FF9D',
        url: '#',
        svgPath: '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>'
      }
    ]
  },
  {
    name: 'guiaRSE',
    description: 'Acompañamiento a las empresas en sus emprendimientos de RSE para potenciar sus resultados.',
    image: '/socios/guiarse.png', 
    roundedClass: 'rounded-premium',
    iconClass: 'text-accent-solar',
    extraClass: 'lg:-translate-y-8 border border-accent-solar/20',
    borderClass: '',
    socials: [
      {
        name: 'LinkedIn',
        color: '#0A66C2',
        url: 'https://www.linkedin.com/company/consultora-guiarse/?originalSubdomain=bo',
        svgPath: '<path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>'
      },
      {
        name: 'Sitio Web',
        color: '#FFA500',
        url: '#',
        svgPath: '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>'
      }
    ]
  },
  {
    name: 'Fundación RENACER',
    description: 'Gestión de proyectos con sectores del área rural para las familias en desventaja de Bolivia.',
    image: '/socios/renacer.png',
    roundedClass: 'rounded-organic-2',
    iconClass: 'icon-gradient',
    extraClass: '',
    borderClass: '',
    socials: [
      {
        name: 'LinkedIn',
        color: '#0A66C2',
        url: 'https://www.linkedin.com/company/fundaci%C3%B3n-renacer/?originalSubdomain=bo',
        svgPath: '<path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>'
      },
      {
        name: 'Sitio Web',
        color: '#10FF9D',
        url: '#',
        svgPath: '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>'
      }
    ]
  },
  {
    name: 'Extend Verde',
    description: 'Brindan servicios ambientales para las corporaciones que requieren una guía en la temática.',
    image: '/socios/extend.png',
    roundedClass: 'rounded-organic-1',
    iconClass: 'icon-gradient',
    extraClass: '',
    borderClass: '',
    socials: [
      {
        name: 'Facebook',
        color: '#1877F2',
        url: 'https://www.facebook.com/ExtendVerde/',
        svgPath: '<path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.469h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.469h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>'
      },
      {
        name: 'YouTube',
        color: '#FF0000',
        url: 'https://www.youtube.com/channel/UC1iEYcKsY3yKX3hNDcUtkFA',
        svgPath: '<path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>'
      },
      {
        name: 'Sitio Web',
        color: '#10FF9D',
        url: 'https://www.extend.com.bo/',
        svgPath: '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>'
      }
    ]
  },
  {
    name: 'Practical Action',
    description: 'Brindan cooperación a las comunidades desfavorecidas en temas de energía.',
    image: '/socios/practical.png',
    roundedClass: 'rounded-premium',
    iconClass: 'text-accent-solar',
    extraClass: 'lg:-translate-y-8 border border-accent-solar/20',
    borderClass: '',
    socials: [
      {
        name: 'Facebook',
        color: '#1877F2',
        url: 'https://www.facebook.com/PracticalActionEnBolivia/',
        svgPath: '<path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.469h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.469h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>'
      },
      {
        name: 'Sitio Web',
        color: '#FFA500',
        url: 'https://x.com/PA_LatinAmerica',
        svgPath: '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>'
      }
    ]
  },
  {
    name: 'CINER',
    description: 'Un gran apoyo en el aspecto técnico y de documentación en temas de energía renovable.',
    image: '/socios/ciner.png',
    roundedClass: 'rounded-organic-2',
    iconClass: 'icon-gradient',
    extraClass: '',
    borderClass: '',
    socials: [
      {
        name: 'Facebook',
        color: '#1877F2',
        url: 'https://www.facebook.com/ONG.CINER/',
        svgPath: '<path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.469h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.469h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>'
      },
      {
        name: 'Twitter',
        color: '#000000',
        url: 'https://x.com/ONGCINER',
        svgPath: '<path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>'
      },
      {
        name: 'Sitio Web',
        color: '#10FF9D',
        url: 'https://ciner.org/',
        svgPath: '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>'
      }
    ]
  }
])
</script>

<style scoped>
/* Los iconos mantienen su color de marca por defecto, y al hacer hover se llenan con el color y el icono pasa a blanco */
.social-icon-permanent:hover {
  background-color: var(--brand);
  color: white !important;
  box-shadow: 0 10px 20px -5px var(--brand);
}

.social-icon-permanent.instagram:hover {
  background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
  color: white !important;
}
</style>