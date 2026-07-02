<template>
  <div class="max-w-[1200px] mx-auto">
    <div class="panel-hero p-6 sm:p-8 mb-8 md:mb-12">
      <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6">
        <div>
          <h2 class="text-3xl md:text-5xl font-black text-on-surface font-lexend tracking-tighter">Plantillas de <span class="text-accent-neon italic">Certificados</span></h2>
          <p class="text-on-surface/40 mt-2 font-light">Diseña y personaliza los certificados que reciben tus estudiantes.</p>
        </div>
      </div>
    </div>

    <div class="glass-card p-4 sm:p-8 rounded-[32px] md:rounded-[40px]">
       <div class="flex items-center justify-between mb-8">
          <div class="relative w-full md:w-96">
            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface/40">search</span>
            <input type="text" v-model="searchQuery" placeholder="Buscar curso..." class="input-cyber !pl-12 w-full" />
          </div>
       </div>
       
       <div v-if="loading" class="text-center py-20">
          <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-accent-neon mx-auto"></div>
          <p class="mt-4 text-on-surface/50">Cargando cursos...</p>
       </div>
       
       <div v-else-if="filteredCursos.length === 0" class="text-center py-20">
         <span class="material-symbols-outlined text-6xl text-on-surface/20 mb-4 block">workspace_premium</span>
         <h3 class="text-xl font-black text-on-surface tracking-tighter mb-2">No hay cursos encontrados</h3>
         <p class="text-sm text-on-surface/40">Todos los cursos necesitan una plantilla de certificado.</p>
       </div>
       
       <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
         <div v-for="curso in filteredCursos" :key="curso.id" class="group glass-card hover:bg-on-surface/[0.03] rounded-3xl overflow-hidden transition-all duration-300">
           <div class="h-40 bg-on-surface/5 relative overflow-hidden flex items-center justify-center">
             <div v-if="curso.plantilla_certificado" class="w-full h-full relative">
                 <img :src="getImageUrl(curso.plantilla_certificado.background_url)" class="w-full h-full object-cover opacity-50 grayscale group-hover:grayscale-0 group-hover:opacity-100 transition-all duration-500" />
                 <div class="absolute inset-0 flex items-center justify-center bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    <span class="text-white font-bold text-xs uppercase tracking-widest">Vista Previa</span>
                 </div>
             </div>
             <div v-else class="text-center p-6">
                <span class="material-symbols-outlined text-4xl text-on-surface/20 mb-2">description</span>
                <p class="text-xs text-on-surface/40 uppercase font-black tracking-widest">Sin Plantilla</p>
             </div>
           </div>
           
           <div class="p-6">
             <h3 class="text-lg font-bold text-on-surface mb-2 line-clamp-1">{{ curso.titulo }}</h3>
             <div class="flex items-center gap-2 mb-4">
                <span class="w-2 h-2 rounded-full" :class="curso.plantilla_certificado ? 'bg-green-500' : 'bg-amber-500'"></span>
                <span class="text-xs font-bold uppercase tracking-tighter" :class="curso.plantilla_certificado ? 'text-green-500' : 'text-amber-500'">
                    {{ curso.plantilla_certificado ? 'Diseño Listo' : 'Pendiente' }}
                </span>
             </div>
             
             <div class="flex flex-col gap-2">
                <router-link :to="'/admin/certificados/diseno/' + curso.id" class="w-full btn-premium py-3 flex justify-center items-center gap-2" :class="curso.plantilla_certificado ? 'btn-secondary-neon' : 'btn-primary-neon'">
                   <span class="material-symbols-outlined text-sm">{{ curso.plantilla_certificado ? 'edit' : 'add' }}</span>
                   {{ curso.plantilla_certificado ? 'Editar Diseño' : 'Crear Diseño' }}
                </router-link>
                
                <button v-if="curso.plantilla_certificado" 
                        @click="previewPdf(curso.plantilla_certificado.id)" 
                        class="w-full py-3 rounded-2xl bg-cyan-500/10 hover:bg-cyan-600 text-cyan-500 hover:text-white font-bold text-xs uppercase tracking-widest transition-all duration-300 flex items-center justify-center gap-2">
                   <span class="material-symbols-outlined text-sm">visibility</span>
                   Ver Certificado
                </button>
              </div>
           </div>
         </div>
       </div>
     </div>
     
     <!-- PDF Preview Modal -->
     <transition name="fade">
        <div v-if="previewingUrl" class="fixed inset-0 z-[100] flex items-center justify-center p-4 md:p-8 bg-black/90 backdrop-blur-sm">
            <div class="w-full max-w-5xl h-full flex flex-col gap-4 animate-in zoom-in duration-300">
                <div class="flex justify-between items-center bg-white/5 p-4 rounded-2xl border-white/10">
                    <h3 class="text-white font-bold uppercase tracking-widest text-xs">Vista Previa del Certificado</h3>
                    <button @click="previewingUrl = null" class="p-2 hover:bg-white/10 rounded-xl text-white transition-colors">
                        <span class="material-symbols-outlined">close</span>
                    </button>
                </div>
                <div class="flex-grow bg-white rounded-3xl overflow-hidden shadow-2xl relative">
                    <iframe :src="previewingUrl" class="w-full h-full border-0"></iframe>
                </div>
                <div class="flex justify-center gap-4">
                    <button @click="previewingUrl = null" class="btn-premium bg-white/10 !text-white border-white/10">Cerrar Vista</button>
                    <a :href="previewingUrl" download="preview.pdf" class="btn-premium btn-primary-neon">Descargar PDF</a>
                </div>
            </div>
        </div>
     </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import api from '@/services/api';

const cursos = ref([]);
const loading = ref(true);
const searchQuery = ref('');
const previewingUrl = ref(null);

const fetchCursos = async () => {
  loading.value = true;
  try {
    // Necesitamos los cursos con su información de plantilla
    const response = await api.get('/cursos');
    cursos.value = response.data;
    console.log('Cursos cargados en Admin:', cursos.value.map(c => ({ id: c.id, hasTemplate: !!c.plantilla_certificado })));
  } catch (error) {
    console.error('Error fetching courses:', error);
  } finally {
    loading.value = false;
  }
};

const getImageUrl = (url) => {
  if (!url) return null;
  if (url.startsWith('http')) return url;
  const baseUrl = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '');
  const cleanUrl = url.startsWith('/') ? url : `/${url}`;
  return `${baseUrl}${cleanUrl}`;
};

const filteredCursos = computed(() => {
  if (!searchQuery.value) return cursos.value;
  const q = searchQuery.value.toLowerCase();
  return cursos.value.filter(c => c.titulo.toLowerCase().includes(q));
});

const previewPdf = (plantillaId) => {
  if (!plantillaId) return;
  const baseUrl = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '');
  const timestamp = new Date().getTime();
  const token = localStorage.getItem('access_token') || '';
  previewingUrl.value = `${baseUrl}/certificados/preview/${plantillaId}?t=${timestamp}&token=${token}`;
};

onMounted(() => {
  fetchCursos();
});
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

.zoom-in {
  animation: zoom-in 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@keyframes zoom-in {
  from {
    transform: scale(0.95);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
