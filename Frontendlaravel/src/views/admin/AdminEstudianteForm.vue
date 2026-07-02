<template>
  <div class="max-w-4xl mx-auto space-y-10 animate-fade-in text-on-surface">
    <!-- Header -->
    <div class="flex items-center gap-6">
      <button @click="$router.back()" class="w-12 h-12 rounded-2xl bg-on-surface/5 flex items-center justify-center text-on-surface/60 hover:bg-accent-neon/10 hover:text-accent-neon transition-all">
        <span class="material-symbols-outlined">arrow_back</span>
      </button>
      <div>
        <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">
          {{ isEdit ? 'Editar' : 'Registrar' }} <span class="text-accent-neon italic">Estudiante</span>
        </h2>
        <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">
          {{ isEdit ? 'Actualiza la información del alumno' : 'Añade un nuevo alumno manualmente' }}
        </p>
      </div>
    </div>

    <form @submit.prevent="saveEstudiante" class="glass-card p-10 rounded-[40px] space-y-8 relative overflow-hidden">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <!-- Personal Info -->
        <div class="space-y-6">
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Nombres</label>
            <input v-model="form.nombres" type="text" required placeholder="Ej. Juan Pablo"
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Apellidos</label>
            <input v-model="form.apellidos" type="text" required placeholder="Ej. Pérez"
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Carnet de Identidad (CI)</label>
            <input v-model="form.ci" type="text" placeholder="Ej. 1234567 LP"
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Correo Electrónico</label>
            <input v-model="form.correo" type="email" required placeholder="correo@ejemplo.com"
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
        </div>

        <!-- Account Info -->
        <div class="space-y-6">
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Teléfono</label>
            <input v-model="form.telefono" type="text" placeholder="+591 ..."
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Contraseña {{ isEdit ? '(Opcional)' : '' }}</label>
            <input v-model="form.contrasena" :required="!isEdit" type="password" placeholder="••••••••"
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">Estado</label>
            <select v-model="form.estado" class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none appearance-none">
              <option value="ACTIVO">ACTIVO</option>
              <option value="INACTIVO">INACTIVO</option>
            </select>
          </div>
          <div class="space-y-2">
            <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em] ml-4">URL Imagen de Perfil</label>
            <input v-model="form.imagen_perfil" type="text" placeholder="https://..."
              class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon focus:ring-0 transition-all outline-none" />
          </div>
          <div class="pt-4 flex items-center gap-4 ml-4">
             <input v-model="form.correo_verificado" type="checkbox" id="verificado" class="w-5 h-5 rounded bg-on-surface/5 text-accent-neon focus:ring-accent-neon" />
             <label for="verificado" class="text-[10px] font-black text-on-surface/40 uppercase tracking-[0.2em]">Correo Verificado</label>
          </div>
        </div>
      </div>

      <div class="pt-6 flex justify-end gap-4">
        <button type="button" @click="$router.back()" class="px-8 py-4 rounded-2xl text-xs font-black uppercase tracking-widest text-on-surface/40 hover:text-on-surface transition-all">
          Cancelar
        </button>
        <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon !py-4 !px-12 gap-2 relative overflow-hidden">
          <div v-if="saving" class="shimmer-effect"></div>
          <span v-if="!saving" class="material-symbols-outlined text-sm">save</span>
          <div v-else class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></div>
          {{ saving ? 'Procesando...' : (isEdit ? 'Actualizar' : 'Registrar Estudiante') }}
        </button>
      </div>
    </form>

  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'

const route = useRoute()
const router = useRouter()
const notificationStore = useNotificationStore()
const isEdit = computed(() => !!route.params.id)

const form = ref({
  nombres: '',
  apellidos: '',
  ci: '',
  correo: '',
  telefono: '',
  contrasena: '',
  imagen_perfil: '',
  estado: 'ACTIVO',
  correo_verificado: false
})

const loading = ref(false)
const saving = ref(false)

const fetchEstudiante = async () => {
  if (!isEdit.value) return
  loading.value = true
  try {
    const res = await api.get(`/usuarios/${route.params.id}`)
    const { contrasena_hash, ...data } = res.data
    form.value = { ...data, contrasena: '' }
  } catch (error) {
    console.error('Error fetching student:', error)
  } finally {
    loading.value = false
  }
}

const saveEstudiante = async () => {
  saving.value = true
  try {
    // Definir campos que NO deben enviarse al backend (relaciones o metadatos)
    const excludeFields = [
      'id', 'rol', 'inscripciones', 'intentos_evaluacion', 
      'auditoria_logs', 'certificados', 'clases_creadas', 
      'cursos_instructor', 'dispositivos', 'notificaciones', 
      'participaciones', 'progreso_lecciones', 'tokens_recuperacion',
      'fecha_creacion', 'fecha_actualizacion', 'refresh_token', 'google_id',
      'ultimo_login', 'hasPassword', 'contrasena_hash'
    ]

    const payload = {}
    Object.keys(form.value).forEach(key => {
      if (!excludeFields.includes(key) && form.value[key] !== undefined) {
        payload[key] = form.value[key]
      }
    })
    
    // Manejo especial de contraseña: solo enviar si no está vacía
    if (!payload.contrasena) {
      delete payload.contrasena
    }
    
    if (isEdit.value) {
      await api.patch(`/usuarios/${route.params.id}`, payload)
    } else {
      // Para creación manual, nos aseguramos de tener un rol
      if (!payload.rol_id) {
        const rolesRes = await api.get('/roles')
        const studentRole = rolesRes.data.find(r => r.nombre.toLowerCase() === 'estudiante')
        if (studentRole) {
          payload.rol_id = studentRole.id
        }
      }
      
      if (!payload.contrasena) {
        throw new Error('La contraseña es obligatoria para nuevos registros')
      }

      await api.post('/usuarios', payload)
    }
    
    notificationStore.addNotification({
      title: isEdit.value ? 'Estudiante Actualizado' : 'Estudiante Registrado',
      message: `El estudiante ${payload.nombres} ha sido ${isEdit.value ? 'actualizado' : 'registrado'} correctamente.`,
      type: 'success'
    })
    
    router.push('/admin/estudiantes')
  } catch (error) {
    console.error('Error saving student:', error)
    const errorData = error.response?.data
    let errorMsg = 'Error al guardar el estudiante'
    
    if (errorData) {
      if (Array.isArray(errorData.message)) {
        errorMsg = errorData.message.join(', ')
      } else {
        errorMsg = errorData.message || errorData.error || errorMsg
      }
    } else {
      errorMsg = error.message || errorMsg
    }
    
    notificationStore.addNotification({
      title: 'Error de Servidor',
      message: errorMsg,
      type: 'error'
    })
  } finally {
    saving.value = false
  }
}

onMounted(() => {
  fetchEstudiante()
})
</script>
