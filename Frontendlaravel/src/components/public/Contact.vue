<template>
  <section id="contacto" class="py-20 md:py-40 relative overflow-hidden bg-background">
    
    <!-- Elementos de brillo de fondo ambiental -->
    <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[700px] h-[700px] bg-accent-neon/5 rounded-full blur-[140px] pointer-events-none"></div>

    <div class="w-full max-w-[1400px] mx-auto px-6 relative z-10">
      
      <!-- Encabezado -->
      <div class="text-center mb-16 md:mb-24 animate-in fade-in slide-in-from-top duration-1000">
        <span class="text-accent-neon font-black tracking-[0.5em] uppercase text-[10px] mb-4 block">Ponte en contacto</span>
        <h2 class="font-lexend text-4xl md:text-5xl font-black text-on-surface">Inicia tu camino hacia la <span class="text-gradient-neon not-italic">Transición Energética</span></h2>
      </div>

      <!-- Grid Principal: Info de Contacto & Formulario -->
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 md:gap-12 items-start">
        
        <!-- Tarjetas de Información (Estilo Glass, sin líneas blancas) -->
        <div class="lg:col-span-5 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-6">
          
          <!-- Card Ubicación -->
          <div class="bg-surface-container p-8 relative group/card transition-all duration-500 hover:-translate-y-2 rounded-organic-1 shadow-xl hover:shadow-[0_20px_60px_rgba(0,0,0,0.3)] flex flex-col justify-between border border-white/5">
            <!-- Usamos border-white/5 apenas visible en vez de on-surface/5 -->
            <span class="text-7xl md:text-8xl absolute -top-4 -left-4 opacity-5 font-serif transition-all duration-500 group-hover/card:opacity-10 group-hover/card:scale-110 pointer-events-none icon-gradient">📍</span>
            <div class="relative z-10">
              <div class="w-14 h-14 rounded-2xl bg-background flex items-center justify-center text-[#4285F4] shadow-inner mb-6 group-hover/card:scale-110 transition-transform border border-white/5">
                <span class="material-symbols-outlined text-2xl">location_on</span>
              </div>
              <h5 class="font-black text-on-surface text-xl leading-tight mb-2">Ubicación</h5>
              <p class="text-on-surface/70 leading-relaxed text-base font-light">
                Calle Condori, N°118, Zona Marquirivi, Anari, Municipio de Achocalla, La Paz, Bolivia
              </p>
            </div>
          </div>

          <!-- Card Teléfono -->
          <div class="bg-surface-container p-8 relative group/card transition-all duration-500 hover:-translate-y-2 rounded-premium shadow-xl hover:shadow-[0_20px_60px_rgba(0,0,0,0.3)] flex flex-col justify-between border border-accent-solar/10">
            <span class="text-7xl md:text-8xl absolute -top-4 -left-4 opacity-5 font-serif transition-all duration-500 group-hover/card:opacity-10 group-hover/card:scale-110 pointer-events-none text-accent-solar">📞</span>
            <div class="relative z-10">
              <div class="w-14 h-14 rounded-2xl bg-background flex items-center justify-center text-[#34A853] shadow-inner mb-6 group-hover/card:scale-110 transition-transform border border-white/5">
                <span class="material-symbols-outlined text-2xl">phone</span>
              </div>
              <h5 class="font-black text-on-surface text-xl leading-tight mb-2">Teléfono / WhatsApp</h5>
              <p class="text-on-surface/70 leading-relaxed text-base font-light">
                +591 73236591
              </p>
            </div>
          </div>

          <!-- Card Email -->
          <div class="bg-surface-container p-8 relative group/card transition-all duration-500 hover:-translate-y-2 rounded-organic-2 shadow-xl hover:shadow-[0_20px_60px_rgba(0,0,0,0.3)] flex flex-col justify-between border border-white/5">
            <span class="text-7xl md:text-8xl absolute -top-4 -left-4 opacity-5 font-serif transition-all duration-500 group-hover/card:opacity-10 group-hover/card:scale-110 pointer-events-none icon-gradient">✉️</span>
            <div class="relative z-10">
              <div class="w-14 h-14 rounded-2xl bg-background flex items-center justify-center text-[#EA4335] shadow-inner mb-6 group-hover/card:scale-110 transition-transform border border-white/5">
                <span class="material-symbols-outlined text-2xl">mail</span>
              </div>
              <h5 class="font-black text-on-surface text-xl leading-tight mb-2">Correo Electrónico</h5>
              <p class="text-on-surface/70 leading-relaxed text-base font-light">
                info@enervida.com
              </p>
            </div>
          </div>

        </div>

        <!-- Formulario de Contacto Pro (Estilo Tarjeta Principal, Sin Líneas Blancas) -->
        <div class="lg:col-span-7">
          <div class="bg-surface-container p-8 md:p-14 relative group/card rounded-organic-2 shadow-2xl border border-white/5">
            <h3 class="font-lexend text-2xl md:text-3xl font-black text-on-surface mb-6">Envíanos un <span class="text-gradient-neon not-italic">Mensaje</span></h3>
            
            <form @submit.prevent="handleSubmit" class="space-y-6 relative z-10">
              
              <div class="grid md:grid-cols-2 gap-6">
                <!-- Nombre -->
                <div class="space-y-2">
                  <label class="block text-xs font-black uppercase tracking-wider text-on-surface/80">Nombre completo</label>
                  <input 
                    type="text" 
                    v-model="form.name" 
                    required
                    placeholder="Ej. Juan Pérez" 
                    class="w-full bg-background border border-white/5 rounded-2xl px-5 py-4 text-on-surface placeholder:text-on-surface/30 text-sm font-medium focus:outline-none focus:border-accent-neon focus:ring-2 focus:ring-accent-neon/20 transition-all"
                  />
                </div>
                <!-- Correo -->
                <div class="space-y-2">
                  <label class="block text-xs font-black uppercase tracking-wider text-on-surface/80">Correo electrónico</label>
                  <input 
                    type="email" 
                    v-model="form.email" 
                    required
                    placeholder="juan@example.com" 
                    class="w-full bg-background border border-white/5 rounded-2xl px-5 py-4 text-on-surface placeholder:text-on-surface/30 text-sm font-medium focus:outline-none focus:border-accent-neon focus:ring-2 focus:ring-accent-neon/20 transition-all"
                  />
                </div>
              </div>

              <div class="grid md:grid-cols-2 gap-6">
                <!-- Teléfono -->
                <div class="space-y-2">
                  <label class="block text-xs font-black uppercase tracking-wider text-on-surface/80">Teléfono / Celular</label>
                  <input 
                    type="tel" 
                    v-model="form.phone" 
                    placeholder="+591 70000000" 
                    class="w-full bg-background border border-white/5 rounded-2xl px-5 py-4 text-on-surface placeholder:text-on-surface/30 text-sm font-medium focus:outline-none focus:border-accent-neon focus:ring-2 focus:ring-accent-neon/20 transition-all"
                  />
                </div>
                <!-- Asunto -->
                <div class="space-y-2">
                  <label class="block text-xs font-black uppercase tracking-wider text-on-surface/80">Asunto o Interés</label>
                  <select 
                    v-model="form.subject" 
                    class="w-full bg-background border border-white/5 rounded-2xl px-5 py-4 text-on-surface text-sm font-medium focus:outline-none focus:border-accent-neon focus:ring-2 focus:ring-accent-neon/20 transition-all"
                  >
                    <option value="" disabled selected>Selecciona una opción</option>
                    <option value="Cursos y Capacitaciones">Cursos y Capacitaciones</option>
                    <option value="Proyectos Fotovoltaicos">Proyectos Fotovoltaicos</option>
                    <option value="Alianzas y Socios">Alianzas y Socios</option>
                    <option value="Otro">Otra consulta</option>
                  </select>
                </div>
              </div>

              <!-- Mensaje -->
              <div class="space-y-2">
                <label class="block text-xs font-black uppercase tracking-wider text-on-surface/80">Mensaje</label>
                <textarea 
                  v-model="form.message" 
                  required
                  rows="4" 
                  placeholder="¿En qué podemos ayudarte?" 
                  class="w-full bg-background border border-white/5 rounded-2xl px-5 py-4 text-on-surface placeholder:text-on-surface/30 text-sm font-medium focus:outline-none focus:border-accent-neon focus:ring-2 focus:ring-accent-neon/20 transition-all resize-none"
                ></textarea>
              </div>

              <!-- Botón Enviar Pro -->
              <button 
                type="submit" 
                :disabled="isSubmitting"
                class="w-full py-4 px-8 rounded-2xl bg-accent-neon text-background font-black text-sm uppercase tracking-wider hover:opacity-90 hover:scale-[1.01] active:scale-[0.99] transition-all flex items-center justify-center gap-2 shadow-lg shadow-accent-neon/20 disabled:opacity-50 cursor-pointer"
              >
                <span v-if="!isSubmitting" class="material-symbols-outlined text-xl">send</span>
                <span v-if="isSubmitting" class="material-symbols-outlined text-xl animate-spin">progress_activity</span>
                {{ isSubmitting ? 'Enviando mensaje...' : 'Enviar Mensaje' }}
              </button>

              <!-- Alerta de éxito -->
              <div v-if="successMessage" class="p-4 rounded-2xl bg-accent-neon/10 border border-accent-neon/20 text-accent-neon text-sm font-medium text-center animate-fade-in">
                ¡Mensaje enviado con éxito! Nos pondremos en contacto contigo muy pronto.
              </div>
            </form>
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<script setup>
import { reactive, ref } from 'vue'

const isSubmitting = ref(false)
const successMessage = ref(false)

const form = reactive({
  name: '',
  email: '',
  phone: '',
  subject: '',
  message: ''
})

const handleSubmit = () => {
  isSubmitting.value = true
  successMessage.value = false

  // Simulación de envío de API (Aquí implementarás tu lógica real luego)
  setTimeout(() => {
    isSubmitting.value = false
    successMessage.value = true
    
    // Limpiar formulario
    form.name = ''
    form.email = ''
    form.phone = ''
    form.subject = ''
    form.message = ''

    // Ocultar mensaje después de 5 segundos
    setTimeout(() => {
      successMessage.value = false
    }, 5000)
  }, 1500)
}
</script>

<style scoped>
/* Aseguramos que el fondo oscuro de los inputs tenga un ligero borde, sin ser blanco */
input, select, textarea {
    transition: all 0.3s ease;
}
input:focus, select:focus, textarea:focus {
    background-color: #0f172a; /* Un tono más oscuro al hacer foco para dar profundidad */
}
</style>