<template>
  <footer id="contactos" class="bg-surface-container pt-32 pb-16 border-t border-on-surface/5 relative overflow-hidden">
    <!-- Glows -->
    <div class="absolute -top-40 -right-40 w-[600px] h-[600px] bg-accent-neon/5 blur-[120px] rounded-full pointer-events-none"></div>
    <div class="absolute -bottom-40 -left-40 w-[600px] h-[600px] bg-accent-solar/5 blur-[120px] rounded-full pointer-events-none"></div>

    <div class="max-w-7xl mx-auto px-6 relative z-10">
      <div class="grid md:grid-cols-12 gap-12 lg:gap-20 mb-20">
        <!-- Brand & Description -->
        <div class="md:col-span-5 lg:col-span-4">
          <div class="mb-8">
            <AppLogo :img-style="{ height: 'clamp(2.5rem, 5vw, 3.5rem)' }" img-class="w-auto object-contain drop-shadow-md" />
          </div>
          <p class="text-on-surface/80 font-medium text-base leading-relaxed mb-8">
            Elevando los estándares de la educación técnica en energías renovables para un futuro más limpio y tecnológicamente avanzado. Conviértete en el líder que el mundo necesita.
          </p>
          
          <div class="space-y-4 text-sm font-medium text-on-surface/70">
             <a href="mailto:info@enervida.com" class="flex items-center gap-3 hover:text-accent-neon transition-colors group">
               <div class="w-10 h-10 rounded-full bg-background flex items-center justify-center group-hover:bg-accent-neon/10 text-[#EA4335] shadow-sm group-hover:shadow-[#EA4335]/20 transition-all">
                 <span class="material-symbols-outlined text-xl">mail</span>
               </div>
               boris.ardaya@enervida.info
             </a>
             <a href="tel:+59112345678" class="flex items-center gap-3 hover:text-accent-neon transition-colors group">
               <div class="w-10 h-10 rounded-full bg-background flex items-center justify-center group-hover:bg-accent-neon/10 text-[#34A853] shadow-sm group-hover:shadow-[#34A853]/20 transition-all">
                 <span class="material-symbols-outlined text-xl">phone</span>
               </div>
               +591 73236591
             </a>
             <a href="https://maps.app.goo.gl/iJtZk14KVHAVXUtp9" target="_blank" rel="noopener noreferrer" class="flex items-center gap-3 hover:text-accent-neon transition-colors group">
               <div class="w-10 h-10 rounded-full bg-background flex items-center justify-center group-hover:bg-accent-neon/10 text-[#4285F4] shadow-sm group-hover:shadow-[#4285F4]/20 transition-all">
                 <span class="material-symbols-outlined text-xl">location_on</span>
               </div>
               Calle Condori, N°118, Zona Marquirivi, Anari, Municio de Achocalla La Paz Bolivia
             </a>
          </div>
        </div>

        <!-- Spacer -->
        <div class="hidden lg:block lg:col-span-1"></div>

        <!-- Navigation -->
        <div class="md:col-span-3 lg:col-span-3">
          <h6 class="font-black uppercase tracking-[0.2em] text-xs text-on-surface mb-8">Navegación Rápida</h6>
          <ul class="space-y-4 text-on-surface/70 font-medium text-sm">
            <li><a @click.prevent="scrollTo('#inicio')" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all cursor-pointer">Inicio</a></li>
            <li><a @click.prevent="scrollTo('#cursos')" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all cursor-pointer">Nuestros Cursos</a></li>
            <li><a @click.prevent="scrollTo('#impacto')" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all cursor-pointer">Impacto Ambiental</a></li>
            <li><a @click.prevent="scrollTo('#socios')" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all cursor-pointer">Socios</a></li>
            <li><a @click.prevent="scrollTo('#nosotros')" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all cursor-pointer">Nosotros</a></li>
          </ul>
        </div>

        <!-- Legal Links -->
        <div class="md:col-span-4 lg:col-span-4">
          <h6 class="font-black uppercase tracking-[0.2em] text-xs text-on-surface mb-8">Legales</h6>
          <ul class="space-y-4 text-on-surface/70 font-medium text-sm">
            <li><router-link to="/privacy" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all">Política de Privacidad</router-link></li>
            <li><router-link to="/terms" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all">Términos y Condiciones</router-link></li>
            <li><router-link to="/legal" class="hover:text-accent-neon hover:translate-x-1 inline-block transition-all">Aviso Legal</router-link></li>
          </ul>
        </div>
      </div>

      <!-- Social Media Icons -->
      <div class="border-t border-on-surface/5 pt-12 pb-8 flex flex-col md:flex-row items-center justify-between gap-6">
        <p class="text-sm font-medium text-on-surface/50">
          &copy; {{ currentYear }} Enervida. Todos los derechos reservados.
        </p>
        <!--desarrollado por jhonatan-->
        <p class="text-sm font-medium text-on-surface/50">
          Desarrollado por Jhonatan
        </p>

        <div class="flex flex-wrap items-center justify-center gap-4">
          <!-- Facebook -->
          <a href="http://www.facebook.com/Enervida.bo" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom group" style="--brand: #1877F2; color: #1877F2;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.469h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.469h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
          </a>
          <!-- Instagram -->
          <a href="http://www.instagram.com/Enervida.bo" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom instagram group" style="--brand: #E4405F; color: #E4405F;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z"/></svg>
          </a>
          <!-- YouTube -->
          <a href="http://www.youtube.com/channel/UC1Otrq7UZlZrxEpRuQgz9Cg" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom group" style="--brand: #FF0000; color: #FF0000;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/></svg>
          </a>
          <!-- WhatsApp -->
          <a href="https://api.whatsapp.com/send?phone=59173236591&text=Hola!%20Estoy%20interesado%20en%20coordinar%20con%20ENERVIDA!" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom group" style="--brand: #25D366; color: #25D366;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/></svg>
          </a>
          <!-- Telegram -->
          <a href="https://t.me/BorisArdaya" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom group" style="--brand: #26A5E4; color: #26A5E4;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M11.944 0A12 12 0 0 0 0 12a12 12 0 0 0 12 12 12 12 0 0 0 12-12A12 12 0 0 0 12 0a12 12 0 0 0-.056 0zm4.962 7.224c.1-.002.321.023.465.14a.506.506 0 0 1 .171.325c.016.093.036.306.02.472-.18 1.898-.962 6.502-1.36 8.627-.168.9-.499 1.201-.82 1.23-.696.065-1.225-.46-1.9-.902-1.056-.693-1.653-1.124-2.678-1.8-1.185-.78-.417-1.21.258-1.91.177-.184 3.247-2.977 3.307-3.23.007-.032.014-.15-.056-.212s-.174-.041-.249-.024c-.106.024-1.793 1.14-5.061 3.345-.48.33-.913.49-1.302.48-.428-.008-1.252-.241-1.865-.44-.752-.245-1.349-.374-1.297-.789.027-.216.325-.437.893-.663 3.498-1.524 5.83-2.529 6.998-3.014 3.332-1.386 4.025-1.627 4.476-1.635z"/></svg>
          </a>
          <!-- LinkedIn -->
          <a href="http://www.linkedin.com/in/enervida-73236591" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom group" style="--brand: #0A66C2; color: #0A66C2;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg>
          </a>
          <!-- TikTok -->
          <a href="https://www.tiktok.com/@enervida.bo" target="_blank" rel="noopener noreferrer" class="w-12 h-12 rounded-2xl bg-background flex items-center justify-center transition-all duration-300 shadow-sm border border-on-surface/5 hover:-translate-y-1 hover:scale-110 hover:border-transparent social-icon-custom group" style="--brand: #000000; color: #000000;">
            <svg class="w-5 h-5 fill-current transition-transform duration-300 group-hover:scale-110" viewBox="0 0 24 24"><path d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 2.23-1.15 4.39-2.9 5.8-1.74 1.4-4.14 2.02-6.38 1.55-2.22-.47-4.18-1.85-5.34-3.79-1.16-1.93-1.39-4.32-.61-6.42.78-2.09 2.53-3.74 4.67-4.41 2.12-.66 4.46-.49 6.42.5v4.18c-1.28-.53-2.83-.55-4.08-.05-1.24.49-2.2 1.55-2.62 2.82-.41 1.26-.26 2.68.41 3.82.68 1.14 1.88 1.89 3.2 2.02 1.3.13 2.64-.17 3.69-.93 1.05-.75 1.74-1.92 1.89-3.23.05-.46.03-.92.03-1.38V.02z"/></svg>
          </a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { useRouter, useRoute } from 'vue-router'
import AppLogo from '@/components/global/AppLogo.vue'

const currentYear = new Date().getFullYear();

const router = useRouter()
const route = useRoute()

const scrollTo = (hash) => {
  if (route.path !== '/') {
    router.push('/').then(() => {
      setTimeout(() => performScroll(hash), 300);
    });
  } else {
    setTimeout(() => performScroll(hash), 100);
  }
}

const performScroll = (hash) => {
  const el = document.querySelector(hash);
  if (el) {
    const yOffset = -80; // offset for fixed navbar
    const y = el.getBoundingClientRect().top + window.pageYOffset + yOffset;
    window.scrollTo({ top: y, behavior: 'smooth' });
  }
}
</script>

<style scoped>
.social-icon-custom:hover {
  background-color: var(--brand);
  color: white !important;
  box-shadow: 0 10px 20px -5px var(--brand);
}

.social-icon-custom.instagram:hover {
  background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
  color: white !important;
}
</style>