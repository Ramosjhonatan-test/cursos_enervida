<template>
  <div class="max-w-[1000px] mx-auto pb-20">
    <div v-if="loading" class="flex justify-center py-20">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-accent-neon mx-auto"></div>
    </div>
    
    <div v-else-if="curso" class="space-y-8">
      <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-6">
        <div class="flex items-center gap-4">
          <router-link to="/admin/cursos" class="w-11 h-11 rounded-xl bg-on-surface/10 flex items-center justify-center text-on-surface/60 hover:text-white hover:bg-on-surface/20 transition-all shrink-0" title="Volver a Cursos">
            <span class="material-symbols-outlined text-xl">arrow_back</span>
          </router-link>
          <div class="min-w-0">
            <div class="flex flex-wrap items-center gap-3">
              <h2 class="text-2xl sm:text-3xl font-black text-on-surface font-lexend tracking-tighter truncate">{{ curso.titulo }}</h2>
              <span class="px-2 py-1 bg-accent-neon/10 text-accent-neon rounded text-[10px] font-bold uppercase tracking-wider">{{ curso.publicado ? 'Publicado' : 'Privado' }}</span>
              <span class="px-2 py-1 bg-accent-solar/10 text-accent-solar rounded text-[10px] font-bold uppercase tracking-wider">Edición {{ String(curso.edicion_actual || 1).padStart(2, '0') }}</span>
            </div>
            <p class="text-on-surface/40 mt-1 text-sm font-light">Estructura del curso: módulos y lecciones</p>
          </div>
        </div>
        
        <div class="flex flex-wrap gap-3 w-full sm:w-auto">
          <button @click="incrementarEdicion" class="flex items-center gap-2 px-4 py-2.5 rounded-xl bg-accent-neon/10 text-accent-neon hover:bg-accent-neon hover:text-primary font-bold transition-all duration-300" title="Iniciar nueva edición del curso">
            <span class="material-symbols-outlined text-xl">upgrade</span>
            <span class="text-sm">Nueva Edición ({{ String((curso.edicion_actual || 1) + 1).padStart(2, '0') }})</span>
          </button>
          <router-link :to="'/admin/cursos/editar/' + curso.id" class="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-blue-500/10 text-blue-500 hover:bg-blue-600 hover:text-white font-bold transition-all duration-300">
            <span class="material-symbols-outlined text-xl">edit</span>
            <span class="text-sm">Editar Detalles</span>
          </router-link>
          <button @click="showAddModulo = true" class="btn-premium btn-primary-neon !px-4 sm:!px-6 flex-1 sm:flex-none justify-center">
            <span class="material-symbols-outlined text-sm">add</span>
            Módulo
          </button>
        </div>
      </div>

      <!-- Add Modulo Inline Form -->
      <div v-if="showAddModulo" class="glass-card-premium p-6 rounded-3xl">
        <form @submit.prevent="saveModulo" class="flex flex-col md:flex-row gap-4 items-end">
          <div class="w-full md:w-2/3 space-y-2">
            <label class="text-sm font-bold text-on-surface/60">Título del Módulo</label>
            <input type="text" v-model="moduloForm.titulo" required placeholder="Ej. Introducción al Curso" class="input-cyber w-full" />
          </div>
          <div class="w-full md:w-1/3 space-y-2">
            <label class="text-sm font-bold text-on-surface/60">Orden</label>
            <input type="number" v-model="moduloForm.orden_modulo" required min="1" class="input-cyber w-full" />
          </div>
          <div class="flex gap-2 w-full md:w-auto">
            <button type="button" @click="showAddModulo = false" class="btn-premium glass-card hover:bg-on-surface/10 !px-4">Cancelar</button>
            <button type="submit" :disabled="savingModulo" class="btn-premium btn-primary-neon !px-6 flex items-center gap-2">
              <span v-if="savingModulo" class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></span>
              <span v-else class="material-symbols-outlined text-sm">save</span>
              Guardar
            </button>
          </div>
        </form>
      </div>

      <!-- Modulos List -->
      <div v-if="curso.modulos?.length === 0" class="glass-card p-12 rounded-[40px] text-center">
        <span class="material-symbols-outlined text-6xl text-on-surface/20 mb-4 block">view_module</span>
        <h3 class="text-xl font-black text-on-surface tracking-tighter mb-2">No hay módulos</h3>
        <p class="text-sm text-on-surface/40">Comienza agregando el primer módulo de tu curso.</p>
      </div>

      <div v-else class="space-y-6">
        <div v-for="(modulo, index) in curso.modulos" :key="modulo.id" class="glass-card rounded-[32px] overflow-hidden">
          <div class="p-4 sm:p-6 bg-on-surface/5 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
            <div class="flex items-center gap-4 min-w-0">
              <div class="w-8 h-8 rounded-full bg-accent-neon/10 text-accent-neon flex items-center justify-center font-bold text-sm shrink-0">
                {{ modulo.orden_modulo }}
              </div>
              <h3 class="text-lg sm:text-xl font-bold text-on-surface truncate">{{ modulo.titulo }}</h3>
            </div>
            <div class="flex gap-2 w-full sm:w-auto">
              <button @click="openAddLeccion(modulo.id)" class="p-2 bg-accent-neon/10 text-accent-neon hover:bg-accent-neon hover:text-primary rounded-xl transition-colors text-xs sm:text-sm flex items-center gap-1 font-bold flex-1 sm:flex-none justify-center">
                <span class="material-symbols-outlined text-sm">add</span> Lección
              </button>
              <button @click="deleteModulo(modulo.id)" class="w-10 h-10 bg-red-500/10 text-red-500 hover:text-white hover:bg-red-600 rounded-xl transition-all flex items-center justify-center shrink-0" title="Eliminar Módulo">
                <span class="material-symbols-outlined text-xl">delete</span>
              </button>
            </div>
          </div>
          
          <!-- Add Leccion Form Inline -->
          <div v-if="activeModuloForm === modulo.id" class="p-6 bg-on-surface/5">
             <form @submit.prevent="saveLeccion" class="space-y-4">
                <h4 class="font-bold text-accent-neon text-sm mb-4">Nueva Lección en Módulo {{ modulo.orden_modulo }}</h4>
                <div class="grid grid-cols-1 md:grid-cols-12 gap-4">
                  <div class="md:col-span-6 space-y-2">
                    <label class="text-xs font-bold text-on-surface/60">Título</label>
                    <input type="text" v-model="leccionForm.titulo" required placeholder="Título de la lección" class="input-cyber w-full" />
                  </div>
                  <div class="md:col-span-2 space-y-2">
                    <label class="text-xs font-bold text-on-surface/60">Orden</label>
                    <input type="number" v-model="leccionForm.orden_leccion" required min="1" class="input-cyber w-full" />
                  </div>
                  <div class="md:col-span-4 space-y-2">
                    <label class="text-xs font-bold text-on-surface/60">Tipo Contenido</label>
                    <select v-model="leccionForm.tipo_contenido" class="input-cyber w-full appearance-none">
                      <option value="VIDEO">Video</option>
                      <option value="PDF">PDF</option>
                      <option value="TEXTO">Texto</option>
                    </select>
                  </div>
                </div>

                <div v-if="leccionForm.tipo_contenido === 'VIDEO' || leccionForm.tipo_contenido === 'PDF'" class="p-4 rounded-2xl bg-on-surface/5">
                  <div class="flex gap-4 mb-4">
                    <label class="flex items-center gap-2 cursor-pointer">
                      <input type="radio" v-model="uploadMode" value="url" class="text-accent-neon" />
                      <span class="text-sm">URL Externa</span>
                    </label>
                    <label class="flex items-center gap-2 cursor-pointer">
                      <input type="radio" v-model="uploadMode" value="file" class="text-accent-neon" />
                      <span class="text-sm">Subir Archivo</span>
                    </label>
                  </div>

                  <div v-if="uploadMode === 'url'" class="space-y-2">
                    <label class="text-xs font-bold text-on-surface/60">Enlace (URL)</label>
                    <input type="url" v-model="leccionUrl" placeholder="https://..." class="input-cyber w-full" />
                  </div>

                  <div v-else class="space-y-2">
                    <div class="flex gap-2">
                      <input type="file" ref="leccionFileInput" :accept="leccionForm.tipo_contenido === 'VIDEO' ? 'video/*' : 'application/pdf'" class="block  w-full text-sm text-on-surface/60 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-bold file:bg-accent-neon/10 file:text-accent-neon hover:file:bg-accent-neon/20 transition-all"/>
                      <button type="button" @click="uploadLeccionFile" :disabled="uploadingFile" class="btn-premium btn-primary-solar !px-6">
                        <span v-if="uploadingFile" class="animate-spin rounded-full h-3 w-3 border-t-2 border-accent-neon inline-block mr-2"></span>
                        <span>{{ uploadingFile ? 'Subiendo...' : 'Subir' }}</span>
                      </button>
                    </div>
                    
                    <!-- Progress Bar -->
                    <div v-if="uploadingFile || (uploadProgress === 100 && leccionUrl)" class="mt-4 space-y-2">
                      <div class="flex justify-between text-[10px] font-black text-accent-neon uppercase tracking-widest">
                        <span>{{ uploadProgress === 100 ? 'Carga Completada' : 'Progreso de carga' }}</span>
                        <span>{{ uploadProgress }}%</span>
                      </div>
                      <div class="h-1.5 w-full bg-on-surface/5 rounded-full overflow-hidden">
                        <div 
                          class="h-full bg-gradient-to-r from-accent-neon to-accent-neon/40 transition-all duration-300 ease-out shadow-[0_0_10px_rgba(0,255,157,0.3)]"
                          :class="{ '!from-green-400 !to-green-500': uploadProgress === 100 }"
                          :style="{ width: `${uploadProgress}%` }"
                        ></div>
                      </div>
                    </div>

                    <p v-if="leccionUrl && !uploadingFile" class="text-xs text-green-400 mt-2 flex items-center gap-1">
                      <span class="material-symbols-outlined text-sm">check_circle</span>
                      Archivo cargado exitosamente
                    </p>
                  </div>
                </div>

                <div v-if="leccionForm.tipo_contenido === 'TEXTO'" class="space-y-2">
                  <label class="text-xs font-bold text-on-surface/60">Contenido (HTML/Texto)</label>
                  <textarea v-model="leccionForm.contenido" rows="4" class="input-cyber w-full resize-y"></textarea>
                </div>

                <div class="flex justify-end gap-2 pt-2">
                  <button type="button" @click="activeModuloForm = null" class="btn-premium glass-card hover:bg-on-surface/10 !px-4">Cancelar</button>
                  <button type="submit" :disabled="savingLeccion" class="btn-premium btn-primary-neon !px-6">Guardar Lección</button>
                </div>
             </form>
          </div>

          <!-- Lecciones List -->
          <div class="p-6">
            <div v-if="!modulo.lecciones || modulo.lecciones.length === 0" class="text-center py-4">
              <p class="text-sm text-on-surface/40">No hay lecciones en este módulo.</p>
            </div>
            <div v-else class="space-y-3">
              <div v-for="leccion in modulo.lecciones" :key="leccion.id" class="flex items-center justify-between p-4 bg-on-surface/5 rounded-2xl hover:bg-on-surface/[0.08] transition-colors">
                <div class="flex items-center gap-4">
                  <span class="material-symbols-outlined text-on-surface/40">
                    {{ leccion.tipo_contenido === 'VIDEO' ? 'play_circle' : (leccion.tipo_contenido === 'PDF' ? 'picture_as_pdf' : 'article') }}
                  </span>
                  <div>
                    <h4 class="font-bold text-sm text-on-surface">{{ leccion.orden_leccion }}. {{ leccion.titulo }}</h4>
                    <p class="text-xs text-on-surface/40 mt-1">{{ leccion.tipo_contenido }}</p>
                  </div>
                </div>
                <div class="flex gap-2">
                  <!-- Solo boton de eliminar para MVP, edición requeriria modal -->
                  <button @click="deleteLeccion(leccion.id)" class="w-9 h-9 flex items-center justify-center bg-red-500/10 text-red-500 hover:text-white hover:bg-red-600 rounded-xl transition-all" title="Eliminar Lección">
                    <span class="material-symbols-outlined text-xl">delete</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import api from '@/services/api';
import { getFileUrl } from '@/config';
import { useNotificationStore } from '@/stores/notificationStore';
import { useModalStore } from '@/stores/modalStore';

const notificationStore = useNotificationStore();
const modalStore = useModalStore();

const route = useRoute();
const curso = ref(null);
const loading = ref(true);

const showAddModulo = ref(false);
const savingModulo = ref(false);
const moduloForm = ref({ titulo: '', orden_modulo: 1 });

const activeModuloForm = ref(null);
const savingLeccion = ref(false);
const leccionForm = ref({ titulo: '', orden_leccion: 1, tipo_contenido: 'VIDEO', contenido: '' });

const uploadMode = ref('url');
const leccionUrl = ref('');
const leccionFileInput = ref(null);
const uploadingFile = ref(false);
const uploadProgress = ref(0);

const fetchCurso = async (isSilent = false) => {
  if (!isSilent) loading.value = true;
  try {
    const res = await api.get(`/cursos/${route.params.id}`);
    curso.value = res.data;
    if(curso.value.modulos) {
       moduloForm.value.orden_modulo = curso.value.modulos.length + 1;
    }
  } catch (error) {
    console.error('Error fetching course:', error);
  } finally {
    if (!isSilent) loading.value = false;
  }
};

const saveModulo = async () => {
  if (!moduloForm.value.titulo) return;
  savingModulo.value = true;
  try {
    await api.post('/modulos', { ...moduloForm.value, curso_id: curso.value.id });
    showAddModulo.value = false;
    moduloForm.value = { titulo: '', orden_modulo: 1 };
    await fetchCurso(true);
    notificationStore.addNotification({
      title: 'Módulo Guardado',
      message: 'El contenido ha sido sincronizado exitosamente.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error saving modulo:', error);
    notificationStore.addNotification({
      title: 'Error de Módulo',
      message: 'No se pudo crear el módulo en este momento.',
      type: 'error'
    })
  } finally {
    savingModulo.value = false;
  }
};

const deleteModulo = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Módulo?',
    message: 'Esta acción borrará todas las lecciones contenidas en el módulo. No se puede deshacer.',
    confirmText: 'Sí, Eliminar Todo',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/modulos/${id}`);
        notificationStore.addNotification({
          title: 'Módulo Eliminado',
          message: 'La estructura ha sido actualizada.',
          type: 'success'
        })
        await fetchCurso(true);
      } catch (error) {
        console.error('Error deleting modulo:', error);
        notificationStore.addNotification({
          title: 'Acción Bloqueada',
          message: 'Error al eliminar. Verifique dependencias activas.',
          type: 'error'
        })
      }
    }
  })
};

const openAddLeccion = (moduloId) => {
  const modulo = curso.value.modulos.find(m => m.id === moduloId);
  const nextOrder = modulo?.lecciones?.length ? modulo.lecciones.length + 1 : 1;
  
  leccionForm.value = { titulo: '', orden_leccion: nextOrder, tipo_contenido: 'VIDEO', contenido: '' };
  uploadMode.value = 'url';
  leccionUrl.value = '';
  uploadProgress.value = 0;
  activeModuloForm.value = moduloId;
};

const uploadLeccionFile = async () => {
  // Cuando ref se usa dentro de v-for, Vue lo convierte en un array
  const input = Array.isArray(leccionFileInput.value) ? leccionFileInput.value[0] : leccionFileInput.value;
  const file = input?.files?.[0];
  if (!file) {
    notificationStore.addNotification({
      title: 'Sin Archivo',
      message: 'Por favor seleccione un documento o video primero.',
      type: 'warning'
    })
    return
  }

  const formData = new FormData();
  formData.append('file', file);

  uploadingFile.value = true;
  uploadProgress.value = 0;
  try {
    // Usamos tu misma instancia 'api'. Agregamos 'timeout: 0' abajo:
    const res = await api.post('/uploads', formData, {
      timeout: 0, // 👈 Desactiva los 20 segundos SOLO para esta ruta de subida
      headers: { 'Content-Type': 'multipart/form-data' },
      onUploadProgress: (progressEvent) => {
        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
        uploadProgress.value = percentCompleted;
      }
    });
    
    uploadProgress.value = 100; // Asegurar 100% al finalizar
    const url = res.data.url;
    leccionUrl.value = getFileUrl(url);
    notificationStore.addNotification({
      title: 'Carga Exitosa',
      message: 'El recurso multimedia ha sido vinculado.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error uploading leccion file:', error);
    notificationStore.addNotification({
      title: 'Fallo de Carga',
      message: 'No se pudo subir el archivo al servidor.',
      type: 'error'
    })
    uploadProgress.value = 0;
  } finally {
    uploadingFile.value = false;
  }
};


const saveLeccion = async () => {
  if (!leccionForm.value.titulo) return;
  savingLeccion.value = true;
  
  const payload = {
    ...leccionForm.value,
    modulo_id: activeModuloForm.value
  };

  if (payload.tipo_contenido === 'VIDEO') {
    payload.video_url = leccionUrl.value;
  } else if (payload.tipo_contenido === 'PDF') {
    payload.pdf_url = leccionUrl.value;
  }

  try {
    await api.post('/lecciones', payload);
    activeModuloForm.value = null;
    await fetchCurso(true);
    notificationStore.addNotification({
      title: 'Lección Guardada',
      message: 'El contenido académico ha sido actualizado.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error saving leccion:', error);
    notificationStore.addNotification({
      title: 'Error de Lección',
      message: 'No se pudo registrar la nueva lección.',
      type: 'error'
    })
  } finally {
    savingLeccion.value = false;
  }
};

const deleteLeccion = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Lección?',
    message: 'Esta acción removerá el contenido del curso permanentemente.',
    confirmText: 'Borrar Lección',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/lecciones/${id}`);
        notificationStore.addNotification({
          title: 'Lección Removida',
          message: 'El módulo ha sido actualizado.',
          type: 'success'
        })
        await fetchCurso(true);
      } catch (error) {
        console.error('Error deleting leccion:', error);
        notificationStore.addNotification({
          title: 'Error al Borrar',
          message: 'No se pudo eliminar el contenido.',
          type: 'error'
        })
      }
    }
  })
};

const incrementarEdicion = async () => {
  const nuevaEdicion = (curso.value.edicion_actual || 1) + 1;
  try {
    await api.patch(`/cursos/${curso.value.id}`, { edicion_actual: nuevaEdicion });
    curso.value.edicion_actual = nuevaEdicion;
    notificationStore.addNotification({
      title: 'Edición Actualizada',
      message: `El curso se actualizó a la edición ${String(nuevaEdicion).padStart(2, '0')}.`,
      type: 'success'
    });
  } catch (error) {
    console.error('Error al incrementar edición:', error);
    notificationStore.addNotification({
      title: 'Error al cambiar edición',
      message: 'No se pudo actualizar la edición en el servidor.',
      type: 'error'
    });
  }
};

onMounted(() => {
  fetchCurso();
});
</script>
