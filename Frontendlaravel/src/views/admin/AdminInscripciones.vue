<template>
  <div class="space-y-10 animate-fade-in text-on-surface">
    <!-- Header -->
    <div class="panel-hero p-6 sm:p-8 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none">
      <div class="absolute inset-0 bg-accent-neon/5 opacity-50 group-hover:opacity-100 transition-opacity"></div>
      <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
        <div>
          <div class="flex items-center gap-3 mb-2">
            <div class="w-8 h-8 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
              <span class="material-symbols-outlined text-sm">history_edu</span>
            </div>
            <span class="text-[10px] font-black text-accent-neon uppercase tracking-[0.3em]">Gestión Académica</span>
          </div>
          <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">Matriculaciones e <span class="text-accent-neon italic">Inscripciones</span></h2>
          <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">Control total sobre el acceso de estudiantes a los cursos</p>
        </div>
        <button @click="toggleForm()" class="btn-premium btn-accent-neon !py-4 gap-2">
          <span class="material-symbols-outlined text-sm">{{ showForm ? 'close' : 'add_circle' }}</span>
          {{ showForm ? 'Cancelar' : 'Nueva Inscripción' }}
        </button>
      </div>
    </div>

    <!-- Inline Form Panel -->
    <transition name="slide-fade">
      <div v-if="showForm" class="glass-card p-6 sm:p-8 rounded-[32px] !border-none shadow-2xl relative overflow-hidden">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
            <span class="material-symbols-outlined text-sm">{{ isEditing ? 'edit' : 'person_add' }}</span>
          </div>
          <div>
            <h3 class="text-lg font-black text-on-surface font-lexend tracking-tighter">
              {{ isEditing ? 'Editar' : 'Nueva' }} <span class="text-accent-neon italic">Inscripción</span>
            </h3>
            <p class="text-[10px] font-bold text-on-surface/40 uppercase tracking-widest">{{ isEditing ? 'Modifica el estado de la inscripción' : 'Asigna un estudiante a un curso' }}</p>
          </div>
        </div>

        <form @submit.prevent="saveInscripcion" class="space-y-6">
          <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div v-if="!isEditing" class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Seleccionar Estudiante</label>
              <select v-model="form.usuario_id" required class="input-cyber w-full appearance-none cursor-pointer !text-on-surface !bg-on-surface/[0.04] !border-none">
                <option value="" disabled class="bg-surface-container text-on-surface/50">Seleccione un estudiante</option>
                <option v-for="u in usuarios" :key="u.id" :value="u.id" class="bg-surface-container text-on-surface">{{ u.nombres }} {{ u.apellidos }} ({{ u.correo }})</option>
              </select>
            </div>

            <div v-if="!isEditing" class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Seleccionar Curso</label>
              <select v-model="form.curso_id" required class="input-cyber w-full appearance-none cursor-pointer !text-on-surface !bg-on-surface/[0.04] !border-none">
                <option value="" disabled class="bg-surface-container text-on-surface/50">Seleccione un curso</option>
                <option v-for="c in cursos" :key="c.id" :value="c.id" class="bg-surface-container text-on-surface">{{ c.titulo }}</option>
              </select>
            </div>

            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Estado de Inscripción</label>
              <select v-model="form.estado" class="input-cyber w-full appearance-none cursor-pointer !text-on-surface !bg-on-surface/[0.04] !border-none">
                <option value="ACTIVO" class="bg-surface-container text-on-surface">Activo</option>
                <option value="PENDIENTE" class="bg-surface-container text-on-surface">Pendiente</option>
                <option value="INACTIVO" class="bg-surface-container text-on-surface">Inactivo</option>
                <option value="COMPLETADO" class="bg-surface-container text-on-surface">Completado</option>
              </select>
            </div>
          </div>

          <div class="flex justify-end gap-3 pt-2">
            <button type="button" @click="showForm = false" class="btn-premium glass-card justify-center !py-3.5 !px-6">Cancelar</button>
            <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon justify-center !py-3.5 !px-8 gap-2">
              <span v-if="saving" class="animate-spin material-symbols-outlined text-sm">refresh</span>
              {{ isEditing ? 'Actualizar' : 'Inscribir Estudiante' }}
            </button>
          </div>
        </form>
      </div>
    </transition>

    <!-- Filters -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="md:col-span-2 relative">
        <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/40 text-sm">search</span>
        <input 
          v-model="searchQuery" 
          type="text" 
          placeholder="Buscar por estudiante o curso..." 
          class="w-full bg-on-surface/[0.03] rounded-2xl py-4 pl-12 pr-4 text-sm font-bold focus:outline-none focus:border-accent-neon/40 transition-all !border-none"
        />
      </div>
      <select v-model="filterStatus" class="bg-on-surface/[0.03] rounded-2xl py-4 px-6 text-sm font-bold focus:outline-none focus:border-accent-neon/40 transition-all !border-none">
        <option value="ALL">Todos los estados</option>
        <option value="ACTIVO">Activos</option>
        <option value="PENDIENTE">Pendientes</option>
        <option value="INACTIVO">Inactivos</option>
        <option value="COMPLETADO">Completados</option>
      </select>
      <button @click="fetchData" class="btn-premium btn-secondary-glass !py-4 gap-2">
        <span class="material-symbols-outlined text-sm">refresh</span>
        Refrescar
      </button>
    </div>

    <!-- Table -->
    <div class="glass-card-premium rounded-[40px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando inscripciones...</p>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full min-w-[900px] text-left border-separate border-spacing-0">
          <thead>
            <tr class="bg-on-surface/[0.03]">
              <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Estudiante</th>
              <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Curso</th>
              <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Progreso</th>
              <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-center">Estado</th>
              <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in filteredInscripciones" :key="item.id" class="group hover:bg-accent-neon/[0.02] transition-all duration-500 relative">
              <td class="p-6">
                <div class="flex items-center gap-4">
                  <div class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 font-black">
                    {{ item.usuario?.nombres?.[0] || '?' }}
                  </div>
                  <div>
                    <p class="text-xs font-black text-on-surface">{{ item.usuario?.nombres }} {{ item.usuario?.apellidos }}</p>
                    <p class="text-[10px] text-on-surface/40 font-bold">{{ item.usuario?.correo }}</p>
                  </div>
                </div>
              </td>
              <td class="p-6">
                <p class="text-xs font-bold text-on-surface line-clamp-1 max-w-[200px]">{{ item.curso?.titulo }}</p>
                <p class="text-[10px] text-accent-neon font-black uppercase tracking-tighter">ID: #{{ item.curso?.id }}</p>
              </td>
              <td class="p-6">
                <div class="flex items-center gap-3">
                  <div class="flex-1 h-1.5 bg-on-surface/5 rounded-full overflow-hidden">
                    <div class="h-full bg-accent-neon transition-all duration-1000" :style="{ width: `${item.porcentaje_progreso}%` }"></div>
                  </div>
                  <span class="text-[10px] font-black text-on-surface/60">{{ item.porcentaje_progreso }}%</span>
                </div>
              </td>
              <td class="p-6 text-center">
                <span :class="['px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest', getStatusClass(item.estado)]">
                  {{ item.estado }}
                </span>
              </td>
              <td class="p-6 text-right">
                <div class="flex justify-end gap-2">
                  <button @click="editInscripcion(item)" class="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 hover:bg-blue-600 hover:text-white hover:-translate-y-1 transition-all duration-300" title="Editar">
                    <span class="material-symbols-outlined text-xl">edit</span>
                  </button>
                  <button @click="deleteInscripcion(item.id)" class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 hover:bg-red-600 hover:text-white hover:-translate-y-1 transition-all duration-300" title="Eliminar">
                    <span class="material-symbols-outlined text-xl">delete</span>
                  </button>
                </div>
              </td>
            </tr>
            <tr v-if="filteredInscripciones.length === 0 && !loading">
              <td colspan="5" class="p-20 text-center">
                <div class="flex flex-col items-center gap-4 text-on-surface/20">
                  <span class="material-symbols-outlined text-6xl">person_off</span>
                  <p class="text-sm font-black uppercase tracking-widest">No se encontraron inscripciones</p>
                </div>
              </td>
            </tr>
            <tr v-if="!inscripciones.length">
              <td colspan="6" class="px-8 py-20 text-center text-on-surface/20">
                <span class="material-symbols-outlined text-4xl mb-3 block">search_off</span>
                <p class="text-[10px] font-black uppercase tracking-widest">Sin resultados</p>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const inscripciones = ref([])
const usuarios = ref([])
const cursos = ref([])
const loading = ref(true)
const saving = ref(false)
const notificationStore = useNotificationStore()
const modalStore = useModalStore()
const showForm = ref(false)
const isEditing = ref(false)
const searchQuery = ref('')
const filterStatus = ref('ALL')

const form = ref({
  id: null,
  usuario_id: '',
  curso_id: '',
  estado: 'ACTIVO'
})

const filteredInscripciones = computed(() => {
  return inscripciones.value.filter(item => {
    const matchesSearch = 
      item.usuario?.nombres?.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      item.usuario?.apellidos?.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      item.curso?.titulo?.toLowerCase().includes(searchQuery.value.toLowerCase());
    
    const matchesStatus = filterStatus.value === 'ALL' || item.estado === filterStatus.value;
    
    return matchesSearch && matchesStatus;
  });
})

const fetchData = async () => {
  loading.value = true
  try {
    const [resIns, resUsu, resCur] = await Promise.all([
      api.get('/inscripciones'),
      api.get('/usuarios'),
      api.get('/cursos')
    ])
    inscripciones.value = resIns.data
    usuarios.value = resUsu.data.filter(u => u.rol?.nombre === 'estudiante')
    cursos.value = resCur.data
  } catch (error) {
    console.error('Error fetching data:', error)
  } finally {
    loading.value = false
  }
}

const toggleForm = () => {
  if (showForm.value) {
    showForm.value = false
  } else {
    isEditing.value = false
    form.value = { id: null, usuario_id: '', curso_id: '', estado: 'ACTIVO' }
    showForm.value = true
  }
}

const editInscripcion = (item) => {
  isEditing.value = true
  form.value = { ...item }
  showForm.value = true
}

const saveInscripcion = async () => {
  saving.value = true
  try {
    if (isEditing.value) {
      await api.patch(`/inscripciones/${form.value.id}`, { estado: form.value.estado })
    } else {
      await api.post('/inscripciones', form.value)
    }
    await fetchData()
    notificationStore.addNotification({
      title: 'Inscripción Guardada',
      message: 'Los cambios se han aplicado correctamente.',
      type: 'success'
    })
    showForm.value = false
  } catch (error) {
    console.error('Error saving inscripcion:', error)
    notificationStore.addNotification({
      title: 'Error al Guardar',
      message: error.response?.data?.message || 'No se pudo procesar la inscripción.',
      type: 'error'
    })
  } finally {
    saving.value = false
  }
}

const deleteInscripcion = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Inscripción?',
    message: 'Esta acción revocará el acceso del estudiante al curso inmediatamente.',
    confirmText: 'Sí, Eliminar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/inscripciones/${id}`)
        notificationStore.addNotification({
          title: 'Acceso Revocado',
          message: 'La inscripción ha sido eliminada.',
          type: 'success'
        })
        await fetchData()
      } catch (error) {
        console.error('Error deleting:', error)
        notificationStore.addNotification({
          title: 'Error de Eliminación',
          message: 'No se pudo remover la inscripción.',
          type: 'error'
        })
      }
    }
  })
}

const getStatusClass = (estado) => {
  switch (estado) {
    case 'ACTIVO': return 'bg-green-500/10 text-green-500'
    case 'PENDIENTE': return 'bg-orange-500/10 text-orange-500'
    case 'INACTIVO': return 'bg-red-500/10 text-red-500'
    case 'COMPLETADO': return 'bg-blue-500/10 text-blue-500'
    default: return 'bg-on-surface/5 text-on-surface/40'
  }
}

onMounted(fetchData)
</script>

<style scoped>
.slide-fade-enter-active { transition: all 0.35s cubic-bezier(0.23, 1, 0.32, 1); }
.slide-fade-leave-active { transition: all 0.2s ease-in; }
.slide-fade-enter-from { transform: translateY(-12px); opacity: 0; }
.slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
