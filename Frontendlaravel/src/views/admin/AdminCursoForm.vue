<template>
  <div class="w-full max-w-[1400px] mx-auto pb-20">
    <div class="flex items-center gap-4 mb-8">
      <router-link to="/admin/cursos" class="w-10 h-10 rounded-xl glass-card bg-on-surface/5 flex items-center justify-center text-on-surface/60 hover:text-accent-neon hover:bg-accent-neon/10 transition-all shrink-0">
        <span class="material-symbols-outlined text-sm">arrow_back</span>
      </router-link>
      <div class="min-w-0">
        <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter truncate">
          {{ isEditing ? 'Editar' : 'Nuevo' }} <span class="text-accent-neon italic">Curso</span>
        </h2>
        <p class="text-on-surface/40 text-sm font-light truncate">Configura los metadatos y opciones principales del curso.</p>
      </div>
    </div>

    <form @submit.prevent="saveCurso" class="flex flex-col xl:flex-row gap-8 items-start">
      <!-- Left Column: Main Information -->
      <div class="w-full xl:flex-1 min-w-0 space-y-6 order-2 xl:order-1">
        <div class="glass-card p-5 sm:p-8 rounded-[24px] sm:rounded-[32px]">
          <h3 class="text-lg font-bold text-on-surface mb-6 flex items-center gap-2">
            <span class="material-symbols-outlined text-accent-neon">info</span>
            Información Principal
          </h3>
          
          <div class="space-y-6">
            <div class="space-y-2">
              <label class="text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Título del Curso</label>
              <input type="text" v-model="form.titulo" required @input="generateSlug" placeholder="Ej. Curso Completo de Energía Solar" class="input-cyber w-full font-medium" />
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div class="space-y-2">
                <label class="text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Slug o Prefijo</label>
                <input type="text" v-model="form.slug" required placeholder="curso-energia-solar" class="input-cyber w-full opacity-70 text-sm" />
              </div>

              <div class="space-y-2">
                <label class="text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Categoría</label>
                <select v-model="form.categoria_id" required class="input-cyber w-full appearance-none font-medium cursor-pointer !text-on-surface">
                  <option value="" disabled class="bg-surface-container text-on-surface/50">Selecciona una categoría</option>
                  <option v-for="cat in categorias" :key="cat.id" :value="cat.id" class="bg-surface-container text-on-surface">{{ cat.nombre }}</option>
                </select>
              </div>
            </div>

            <div class="space-y-2">
              <label class="text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Descripción Corta</label>
              <input type="text" v-model="form.descripcion_corta" placeholder="Breve resumen para las tarjetas..." class="input-cyber w-full" />
            </div>

            <div class="space-y-2">
              <label class="text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Descripción Completa</label>
              <textarea v-model="form.descripcion" rows="8" placeholder="Detalle exhaustivo del contenido del curso..." class="input-cyber w-full resize-y"></textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- Right Column: Media, Settings, Actions -->
      <div class="w-full xl:w-[380px] flex flex-col gap-6 order-1 xl:order-2">
        
        <!-- Thumbnail Upload -->
        <div class="glass-card p-6 rounded-[24px] sm:rounded-[32px]">
          <h3 class="text-sm font-bold text-on-surface mb-4 flex items-center justify-between">
            <span>Miniatura</span>
            <div class="flex bg-on-surface/5 p-1 rounded-lg gap-1">
              <button type="button" @click="uploadMode = 'file'" :class="['px-3 py-1 text-[10px] rounded-md transition-all font-black uppercase tracking-tighter', uploadMode === 'file' ? 'bg-accent-neon text-primary shadow-lg' : 'text-on-surface/40 hover:text-on-surface']">Archivo</button>
              <button type="button" @click="uploadMode = 'url'" :class="['px-3 py-1 text-[10px] rounded-md transition-all font-black uppercase tracking-tighter', uploadMode === 'url' ? 'bg-accent-neon text-primary shadow-lg' : 'text-on-surface/40 hover:text-on-surface']">URL</button>
            </div>
          </h3>
          
          <div v-if="uploadMode === 'file'" @click="$refs.fileInput.click()" class="group relative aspect-video rounded-2xl bg-on-surface/5 border-2 border-dashed hover:border-accent-neon/50 transition-all cursor-pointer overflow-hidden flex flex-col items-center justify-center gap-4">
            <img v-if="previewUrl" :src="previewUrl" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
            <div v-else class="text-center p-6">
              <span class="material-symbols-outlined text-4xl text-accent-neon mb-2">cloud_upload</span>
              <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Subir Imagen</p>
            </div>
            <div v-if="uploadingImg" class="absolute inset-0 bg-background/80 backdrop-blur-md flex flex-col items-center justify-center p-6 gap-3">
              <div class="animate-spin rounded-full h-8 w-8 border-t-2 border-accent-neon shadow-[0_0_15px_rgba(0,255,204,0.3)]"></div>
              <div class="w-full max-w-[120px]">
                <div class="flex justify-between text-[8px] font-black text-accent-neon uppercase tracking-widest mb-1">
                  <span>Subiendo</span>
                  <span>{{ uploadProgress }}%</span>
                </div>
                <div class="h-1 w-full bg-white/5 rounded-full overflow-hidden">
                  <div 
                    class="h-full bg-accent-neon transition-all duration-300"
                    :style="{ width: `${uploadProgress}%` }"
                  ></div>
                </div>
              </div>
            </div>
          </div>

          <div v-else class="space-y-4">
            <div class="aspect-video rounded-2xl bg-on-surface/5 overflow-hidden relative group">
              <img v-if="form.miniatura_url" :src="form.miniatura_url" class="w-full h-full object-cover" @error="form.miniatura_url = ''" />
              <div v-else class="w-full h-full flex items-center justify-center">
                <span class="material-symbols-outlined text-4xl text-on-surface/10">link</span>
              </div>
            </div>
            <input type="url" v-model="form.miniatura_url" placeholder="https://ejemplo.com/imagen.jpg" class="input-cyber !text-xs" @input="previewUrl = form.miniatura_url" />
          </div>

          <input type="file" ref="fileInput" class="hidden" accept="image/*" @change="handleFileUpload" />
        </div>

        <!-- Settings -->
        <div class="glass-card p-6 rounded-[24px] sm:rounded-[32px] space-y-6">
          <h3 class="text-sm font-bold text-on-surface">Configuración</h3>
          
          <div class="grid grid-cols-2 gap-4">
            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Precio (Bs)</label>
              <div class="relative">
                <span class="absolute left-4 top-1/2 -translate-y-1/2 text-on-surface/50 font-bold">Bs</span>
                <input type="number" v-model="form.precio" step="0.01" min="0" placeholder="0.00" class="input-cyber w-full !pl-10 font-bold text-accent-neon" />
              </div>
            </div>
            
            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Nivel</label>
              <select v-model="form.nivel" class="input-cyber w-full appearance-none cursor-pointer !text-on-surface">
                <option value="Principiante" class="bg-surface-container text-on-surface">Principiante</option>
                <option value="Intermedio" class="bg-surface-container text-on-surface">Intermedio</option>
                <option value="Avanzado" class="bg-surface-container text-on-surface">Avanzado</option>
                <option value="Todos" class="bg-surface-container text-on-surface">Todos</option>
              </select>
            </div>
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Modalidad</label>
              <select v-model="form.tipo_curso" class="input-cyber w-full appearance-none cursor-pointer !text-on-surface">
                <option value="Hibrido" class="bg-surface-container text-on-surface">Híbrido</option>
                <option value="VOD" class="bg-surface-container text-on-surface">Virtual</option>
                <option value="Presencial" class="bg-surface-container text-on-surface">Presencial</option>
              </select> 
            </div>

            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Edición (VV)</label>
              <select v-model="form.edicion_actual" class="input-cyber w-full appearance-none cursor-pointer !text-on-surface">
                <option v-for="n in 99" :key="n" :value="n">
                  {{ String(n).padStart(2, '0') }}
                </option>
              </select>
            </div>
          </div>

          <div class="space-y-4 pt-4">
            <label class="flex items-center justify-between cursor-pointer group p-3 rounded-xl hover:bg-on-surface/5 transition-colors">
              <span class="text-sm font-bold text-on-surface/80 group-hover:text-on-surface transition-colors flex items-center gap-2">
                <span class="material-symbols-outlined text-lg text-accent-solar">workspace_premium</span>
                Certificado
              </span>
              <div class="relative flex items-center justify-center">
                <input type="checkbox" v-model="form.certificado_habilitado" class="sr-only" />
                <div class="w-10 h-6 rounded-full transition-colors relative" :class="{'bg-accent-neon': form.certificado_habilitado, 'bg-gray-200 dark:bg-white/10': !form.certificado_habilitado}">
                  <div class="absolute w-4 h-4 bg-white rounded-full top-1 transition-transform shadow-md border border-gray-200/50 dark:border-transparent"   :class="form.certificado_habilitado ? 'left-5' : 'left-1'"></div>
                </div>
              </div>
            </label>
            
            <label class="flex items-center justify-between cursor-pointer group p-3 rounded-xl hover:bg-on-surface/5 transition-colors">
              <span class="text-sm font-bold text-on-surface/80 group-hover:text-on-surface transition-colors flex items-center gap-2">
                <span class="material-symbols-outlined text-lg text-accent-neon">public</span>
                Publicado
              </span>
              <div class="relative flex items-center justify-center">
                <input type="checkbox" v-model="form.publicado  " class="sr-only" />
                <div class="w-10 h-6 rounded-full transition-colors relative" :class="{'bg-accent-neon': form.publicado, 'bg-gray-200 dark:bg-white/10': !form.publicado}">
                  <div class="absolute w-4 h-4 bg-white rounded-full top-1 transition-transform shadow-md border border-gray-200/50 dark:border-transparent" :class="form.publicado ? 'left-5' : 'left-1'"></div>
                </div>
              </div>
            </label>
          </div>
        </div>

        <!-- Actions -->
        <div class="flex flex-col gap-3 mt-4">
          <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon w-full justify-center relative overflow-hidden">
            <div v-if="saving" class="shimmer-effect"></div>
            <span v-if="!saving" class="material-symbols-outlined text-sm">save</span>
            <div v-else class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></div>
            {{ saving ? 'Guardando...' : (isEditing ? 'Guardar Cambios' : 'Crear Curso') }}
          </button>
          <router-link to="/admin/cursos" class="btn-premium btn-secondary-glass w-full justify-center text-on-surface/60 hover:text-on-surface">
            Cancelar
          </router-link>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import api from '@/services/api';
import { useAuthStore } from '@/stores/auth';
import { useNotificationStore } from '@/stores/notificationStore';
import { getFileUrl } from '@/config';

const router = useRouter();
const route = useRoute();
const authStore = useAuthStore();
const notificationStore = useNotificationStore();

const isEditing = ref(false);
const saving = ref(false);
const uploadingImg = ref(false);
const uploadProgress = ref(0);
const uploadMode = ref('file');
const previewUrl = ref(null);
const fileInput = ref(null);
const categorias = ref([]);

const form = ref({
  titulo: '',
  slug: '',
  categoria_id: '',
  instructor_id: authStore.user?.id || 1,
  descripcion_corta: '',
  descripcion: '',
  miniatura_url: '',
  nivel: 'Todos',
  tipo_curso: 'Hibrido',
  certificado_habilitado: true,
  publicado: false,
  precio: 0,
  edicion_actual: 1
});

// getImageUrl was replaced by getFileUrl from config

const fetchCategorias = async () => {
  try {
    const res = await api.get('/categorias');
    categorias.value = res.data;
  } catch (error) {
    console.error('Error fetching categories:', error);
  }
};

const fetchCurso = async (id) => {
  try {
    const res = await api.get(`/cursos/${id}`);
    const curso = res.data;
    form.value = {
      titulo: curso.titulo,
      slug: curso.slug,
      categoria_id: curso.categoria_id,
      instructor_id: curso.instructor_id,
      descripcion_corta: curso.descripcion_corta || '',
      descripcion: curso.descripcion || '',
      miniatura_url: curso.miniatura_url || '',
      nivel: curso.nivel,
      tipo_curso: curso.tipo_curso,
      certificado_habilitado: curso.certificado_habilitado,
      publicado: curso.publicado,
      precio: curso.precio,
      edicion_actual: curso.edicion_actual ?? 1
    };
    if (curso.miniatura_url) {
      previewUrl.value = getFileUrl(curso.miniatura_url);
      // Si la URL empieza con http (y no es el localhost) o no empieza con /uploads, 
      // asumimos que es una URL pegada manualmente
      if (curso.miniatura_url.startsWith('http') && !curso.miniatura_url.includes('enervida.info')) {
        uploadMode.value = 'url';
      } else if (!curso.miniatura_url.startsWith('/uploads')) {
        uploadMode.value = 'url';
      } else {
        uploadMode.value = 'file';
      }
    }
  } catch (error) {
    console.error('Error fetching course:', error);
    notificationStore.addNotification({
      title: 'Error de Lectura',
      message: 'No se pudieron cargar los datos del curso para edición.',
      type: 'error'
    })
  }
};

const generateSlug = () => {
  if (!isEditing.value) {
    form.value.slug = form.value.titulo
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/(^-|-$)+/g, '');
  }
};

const handleFileUpload = async (event) => {
  const file = event.target.files[0];
  if (!file) return;

  // Mostrar previsualización local instantánea
  previewUrl.value = URL.createObjectURL(file);

  const formData = new FormData();
  formData.append('file', file);

  uploadingImg.value = true;
  uploadProgress.value = 0;
  try {
    const res = await api.post('/uploads', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
      onUploadProgress: (progressEvent) => {
        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
        uploadProgress.value = percentCompleted;
      }
    });
    const url = res.data.url;
    form.value.miniatura_url = url;
    // No sobreescribimos la previewUrl local para evitar parpadeos, 
    // a menos que queramos confirmar la URL final del servidor
  } catch (error) {
    console.error('Error uploading file:', error);
    notificationStore.addNotification({
      title: 'Error de Multimedia',
      message: 'No se pudo procesar la miniatura. Intenta de nuevo.',
      type: 'error'
    })
    previewUrl.value = null; // Limpiar si falló
  } finally {
    uploadingImg.value = false;
  }
};

const saveCurso = async () => {
  saving.value = true;
  
  const payload = {
    ...form.value,
    categoria_id: parseInt(form.value.categoria_id, 10),
    precio: parseFloat(form.value.precio),
    edicion_actual: parseInt(form.value.edicion_actual, 10)
  };

  try {
    if (isEditing.value) {
      await api.patch(`/cursos/${route.params.id}`, payload);
      notificationStore.addNotification({
        title: 'Curso Actualizado',
        message: 'Los cambios se han guardado correctamente.',
        type: 'success'
      });
      router.push(`/admin/cursos/${route.params.id}`);
    } else {
      const response = await api.post('/cursos', payload);
      notificationStore.addNotification({
        title: 'Curso Creado',
        message: 'El nuevo curso ya está disponible en el catálogo.',
        type: 'success'
      });
      router.push(`/admin/cursos/${response.data.id}`);
    }
  } catch (error) {
    console.error('Error saving course:', error);
    notificationStore.addNotification({
      title: 'Error de Guardado',
      message: 'No se pudo procesar la solicitud del curso.',
      type: 'error'
    });
  } finally {
    saving.value = false;
  }
};

onMounted(async () => {
  await fetchCategorias();
  
  // Si no hay categorías, intentar crear una por defecto para que el campo no aparezca vacío
  if (categorias.value.length === 0) {
    try {
      const res = await api.post('/categorias', { 
        nombre: 'General', 
        descripcion: 'Categoría creada automáticamente' 
      });
      categorias.value = [res.data];
    } catch(e) {
      console.warn('No se pudo crear la categoría por defecto. Es posible que falten permisos.');
      // Fallback local visual por si el backend falla
      categorias.value = [{ id: 1, nombre: 'Sin Categoría' }];
    }
  }

  if (route.params.id) {
    isEditing.value = true;
    await fetchCurso(route.params.id);
  }
});
</script>
