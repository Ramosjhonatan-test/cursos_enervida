<template>
  <div v-if="estudiante" class="space-y-10 animate-fade-in text-on-surface">
    <!-- Header with Back Button -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-6">
      <div class="flex items-center gap-6">
        <button @click="$router.back()" class="w-11 h-11 rounded-xl bg-on-surface/10 flex items-center justify-center text-on-surface/60 hover:bg-on-surface/20 transition-all" title="Volver">
          <span class="material-symbols-outlined text-xl">arrow_back</span>
        </button>
        <div>
          <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">Detalle del <span class="text-accent-neon italic">Estudiante</span></h2>
          <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">Expediente académico y actividad reciente</p>
        </div>
      </div>
      <div class="flex gap-4">
        <button @click="toggleStatus" :class="['btn-premium !py-4 gap-2', estudiante.estado === 'ACTIVO' ? 'btn-secondary-glass hover:!text-red-500' : 'btn-primary-neon']">
          <span class="material-symbols-outlined text-sm">{{ estudiante.estado === 'ACTIVO' ? 'block' : 'check_circle' }}</span>
          {{ estudiante.estado === 'ACTIVO' ? 'Desactivar Cuenta' : 'Activar Cuenta' }}
        </button>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Left Column: Profile Card -->
      <div class="lg:col-span-1 space-y-8">
        <div class="glass-card p-10 rounded-[40px] text-center relative overflow-hidden">
          <div class="relative z-10">
            <div class="w-32 h-32 rounded-[40px] bg-on-surface/5 p-1 mx-auto mb-6 shadow-2xl overflow-hidden group">
              <img :src="estudiante.imagen_perfil || 'https://i.pravatar.cc/150?u=' + estudiante.id" class="w-full h-full object-cover rounded-[32px] group-hover:scale-110 transition-transform duration-700" />
            </div>
            <h3 class="text-2xl font-black text-on-surface font-lexend leading-tight">{{ estudiante.nombres }} {{ estudiante.apellidos }}</h3>
            <p class="text-accent-neon font-black text-[10px] uppercase tracking-[0.3em] mt-2">{{ estudiante.rol?.nombre }}</p>
            
            <div class="mt-10 space-y-4 text-left">
              <div class="flex items-center gap-4 p-4 rounded-2xl bg-on-surface/5">
                <span class="material-symbols-outlined text-on-surface/40">mail</span>
                <span class="text-xs font-bold text-on-surface/60">{{ estudiante.correo }}</span>
              </div>
              <div class="flex items-center gap-4 p-4 rounded-2xl bg-on-surface/5">
                <span class="material-symbols-outlined text-on-surface/40">calendar_today</span>
                <div class="flex flex-col">
                  <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Miembro desde</span>
                  <span class="text-xs font-bold text-on-surface/60">{{ new Date(estudiante.fecha_creacion).toLocaleDateString() }}</span>
                </div>
              </div>
              <div class="flex items-center gap-4 p-4 rounded-2xl bg-on-surface/5">
                <span class="material-symbols-outlined text-on-surface/40">login</span>
                <div class="flex flex-col">
                  <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Último acceso</span>
                  <span class="text-xs font-bold text-on-surface/60">{{ estudiante.ultimo_login ? new Date(estudiante.ultimo_login).toLocaleString() : 'Nunca' }}</span>
                </div>
              </div>
            </div>
          </div>
          <div class="absolute -top-10 -right-10 w-40 h-40 bg-accent-neon/5 rounded-full blur-3xl"></div>
        </div>

        <!-- Registered Device Info -->
        <div class="glass-card p-10 rounded-[40px]">
          <div class="flex justify-between items-center mb-6">
            <h4 class="text-sm font-black text-on-surface uppercase tracking-widest">Seguridad / Dispositivo</h4>
            <span v-if="estudiante.dispositivos?.length" class="flex h-2 w-2 rounded-full bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.6)]"></span>
          </div>

          <div v-if="estudiante.dispositivos?.length" class="space-y-6">
            <div v-for="dev in estudiante.dispositivos" :key="dev.id" class="p-4 rounded-2xl bg-on-surface/5">
              <div class="flex items-center gap-3 mb-3">
                <span class="material-symbols-outlined text-accent-neon text-lg">
                  {{ getDeviceIcon(dev.sistema_operativo) }}
                </span>
                <span class="text-xs font-black text-on-surface">{{ dev.nombre_dispositivo || 'Dispositivo Vinculado' }}</span>
              </div>
              <div class="space-y-2">
                <p class="text-[10px] text-on-surface/40 font-bold uppercase flex justify-between">
                  <span>Navegador:</span>
                  <span class="text-on-surface/60">{{ dev.navegador }}</span>
                </p>
                <p class="text-[10px] text-on-surface/40 font-bold uppercase flex justify-between">
                  <span>S.O:</span>
                  <span class="text-on-surface/60">{{ dev.sistema_operativo }}</span>
                </p>
                <p class="text-[10px] text-on-surface/40 font-bold uppercase flex justify-between">
                  <span>Última IP:</span>
                  <span class="text-on-surface/60">{{ dev.direccion_ip || 'N/A' }}</span>
                </p>
                <p class="text-[10px] text-on-surface/40 font-bold uppercase flex justify-between">
                  <span>Activo desde:</span>
                  <span class="text-on-surface/60">{{ new Date(dev.fecha_creacion).toLocaleDateString() }}</span>
                </p>
              </div>
            </div>

            <button @click="liberateDevices" class="w-full py-4 rounded-xl bg-red-500/10 text-red-500 text-[10px] font-black uppercase tracking-widest hover:bg-red-600 hover:text-white transition-all flex items-center justify-center gap-2">
              <span class="material-symbols-outlined text-sm">lock_open</span>
              Liberar Cuenta (Desvincular)
            </button>
            <p class="text-[8px] text-on-surface/30 text-center uppercase font-bold leading-relaxed">
              Al liberar la cuenta, el estudiante podrá vincular un nuevo dispositivo en su próximo inicio de sesión.
            </p>
          </div>
          
          <div v-else class="text-center py-10">
            <span class="material-symbols-outlined text-on-surface/10 text-4xl mb-2">devices_off</span>
            <p class="text-[10px] font-black text-on-surface/20 uppercase tracking-widest">Sin dispositivos vinculados</p>
          </div>
        </div>

        <!-- Recent Activity Logs -->
        <div class="glass-card p-10 rounded-[40px]">
          <div class="flex justify-between items-center mb-8">
            <h4 class="text-sm font-black text-on-surface uppercase tracking-widest">Actividad Reciente</h4>
            <button @click="toggleAllLogs" class="text-[9px] font-black text-accent-neon uppercase tracking-widest hover:underline">
              {{ allLogsExpanded ? 'Contraer Todo' : 'Expandir Todo' }}
            </button>
          </div>
          
          <div class="max-h-[500px] overflow-y-auto pr-2 space-y-4 custom-scrollbar">
            <div v-for="(logs, date) in logsAgrupados" :key="date" class="space-y-3">
              <button @click="toggleLogGroup(date)" class="w-full flex items-center gap-4 group py-1 sticky top-0 bg-surface/80 backdrop-blur-md z-10">
                <span class="text-[9px] font-black text-accent-neon uppercase tracking-[0.2em] whitespace-nowrap">{{ date }}</span>
                <div class="h-px w-full bg-on-surface/10"></div>
                <span class="material-symbols-outlined text-xs text-on-surface/20 group-hover:text-accent-neon transition-transform" :class="{ 'rotate-180': expandedGroups[date] }">expand_more</span>
              </button>
              
              <div v-if="expandedGroups[date]" class="space-y-4 pl-2 animate-slide-down">
                <div v-for="log in logs" :key="log.id" class="flex gap-4 group">
                  <div class="w-1.5 h-1.5 rounded-full bg-on-surface/20 mt-1.5 group-hover:bg-accent-neon transition-colors shrink-0 shadow-[0_0_5px_transparent] group-hover:shadow-accent-neon/50"></div>
                  <div class="flex-1 min-w-0">
                    <p class="text-[11px] font-bold text-on-surface/80 group-hover:text-on-surface transition-colors leading-tight break-words">{{ log.accion }}</p>
                    <div class="flex items-center gap-2 mt-1">
                      <p class="text-[9px] text-on-surface/40 uppercase font-medium">{{ new Date(log.fecha_creacion).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) }}</p>
                      <span v-if="log.direccion_ip" class="text-[8px] text-on-surface/20 font-mono">{{ log.direccion_ip }}</span>
                    </div>
                    <p v-if="log.descripcion" class="text-[9px] text-on-surface/30 mt-1 italic line-clamp-2 hover:line-clamp-none transition-all">{{ log.descripcion }}</p>
                  </div>
                </div>
              </div>
            </div>
            <p v-if="!estudiante.auditoria_logs?.length" class="text-center py-6 text-on-surface/20 text-[10px] font-black uppercase tracking-widest">Sin registros</p>
          </div>
        </div>
      </div>

      <!-- Right Column: Courses and Grades -->
      <div class="lg:col-span-2 space-y-8">
        <!-- Enrolled Courses -->
        <div class="glass-card p-10 rounded-[40px]">
          <div class="flex justify-between items-center mb-10">
            <h4 class="text-xl font-black font-lexend tracking-tighter italic">Cursos <span class="text-accent-neon">Inscritos</span></h4>
            <span class="px-3 py-1 bg-accent-neon/10 text-accent-neon text-[10px] font-black rounded-full">
              {{ estudiante.inscripciones?.length || 0 }} Total
            </span>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div v-for="ins in estudiante.inscripciones" :key="ins.id" class="p-6 rounded-[32px] bg-on-surface/5 group hover:bg-on-surface/[0.08] transition-all">
              <div class="flex justify-between items-start mb-4">
                <div class="w-12 h-12 rounded-xl bg-on-surface/10 overflow-hidden shrink-0">
                  <img :src="getImageUrl(ins.curso.miniatura_url)" class="w-full h-full object-cover" />
                </div>
                <div class="flex flex-col items-end gap-2">
                  <span :class="['px-2 py-0.5 text-[8px] font-black rounded-md uppercase tracking-widest', ins.estado === 'ACTIVO' ? 'bg-green-500/20 text-green-500' : 'bg-yellow-500/20 text-yellow-500']">
                    {{ ins.estado }}
                  </span>
                  <button v-if="ins.estado === 'PENDIENTE'" @click="approveEnrollment(ins.id)" class="px-3 py-1.5 bg-emerald-500/10 text-emerald-500 text-[9px] font-black rounded-lg hover:bg-emerald-600 hover:text-white transition-all uppercase tracking-wider">
                    Aprobar Pago
                  </button>
                  <div class="flex flex-col gap-2 sm:flex-row sm:justify-end">
                    <button
                      v-if="hasCertificateForCourse(ins.curso.id)"
                      @click="emitirCertificadoCurso(ins.curso.id, ins.curso.titulo)"
                      :disabled="certificateLoadingByCourse[ins.curso.id]"
                      class="px-3 py-1.5 bg-violet-500/10 text-violet-400 text-[9px] font-black rounded-lg hover:bg-violet-500 hover:text-white transition-all uppercase tracking-wider flex items-center gap-1 disabled:opacity-40"
                    >
                      <span v-if="certificateLoadingByCourse[ins.curso.id]" class="material-symbols-outlined text-[12px] animate-spin">sync</span>
                      <span v-else class="material-symbols-outlined text-[12px]">workspace_premium</span>
                      Reemitir certificado
                    </button>

                    <button
                      v-else-if="hasApprovedAttemptForCourse(ins.curso.id)"
                      @click="emitirCertificadoCurso(ins.curso.id, ins.curso.titulo)"
                      :disabled="certificateLoadingByCourse[ins.curso.id]"
                      class="px-3 py-1.5 bg-violet-500/10 text-violet-400 text-[9px] font-black rounded-lg hover:bg-violet-500 hover:text-white transition-all uppercase tracking-wider flex items-center gap-1 disabled:opacity-40"
                    >
                      <span v-if="certificateLoadingByCourse[ins.curso.id]" class="material-symbols-outlined text-[12px] animate-spin">sync</span>
                      <span v-else class="material-symbols-outlined text-[12px]">workspace_premium</span>
                      Emitir certificado
                    </button>

                    <button
                      v-else
                      @click="emitirCertificadoCurso(ins.curso.id, ins.curso.titulo, true)"
                      :disabled="certificateLoadingByCourse[ins.curso.id]"
                      class="px-3 py-1.5 bg-red-500/10 text-red-400 text-[9px] font-black rounded-lg hover:bg-red-500 hover:text-white transition-all uppercase tracking-wider flex items-center gap-1 disabled:opacity-40"
                    >
                      <span v-if="certificateLoadingByCourse[ins.curso.id]" class="material-symbols-outlined text-[12px] animate-spin">sync</span>
                      <span v-else class="material-symbols-outlined text-[12px]">warning</span>
                      Emitir manual
                    </button>
                  </div>
                </div>
              </div>
              <h5 class="text-sm font-black text-on-surface mb-4 line-clamp-1 group-hover:text-accent-neon transition-colors">{{ ins.curso.titulo }}</h5>
              <div class="flex justify-between items-end mb-2">
                <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Progreso</span>
                <span class="text-xs font-black text-accent-neon">{{ Math.round(ins.porcentaje_progreso) }}%</span>
              </div>
              <div class="h-1.5 bg-on-surface/10 rounded-full overflow-hidden">
                <div class="h-full bg-accent-neon rounded-full shadow-[0_0_10px_var(--accent-neon)] transition-all duration-1000" :style="{ width: ins.porcentaje_progreso + '%' }"></div>
              </div>
            </div>
            <div v-if="!estudiante.inscripciones?.length" class="col-span-full py-20 text-center text-on-surface/20 bg-on-surface/[0.03] rounded-[32px]">
               <span class="material-symbols-outlined text-4xl mb-2">auto_stories</span>
               <p class="text-[10px] font-black uppercase tracking-widest">No está inscrito en ningún curso</p>
            </div>
          </div>
        </div>

        <!-- Evaluation Attempts -->
        <div class="glass-card-premium rounded-[20px] overflow-hidden shadow-2xl !border-none">
          <div class="px-8 pt-8 pb-4 flex items-center justify-between">
            <h4 class="text-xl font-black font-lexend tracking-tighter italic">Historial de <span class="text-accent-neon">Evaluaciones</span></h4>
            <div class="flex items-center gap-3">
              <span class="px-3 py-1 bg-accent-neon/10 text-accent-neon text-[10px] font-black rounded-full">{{ estudiante.intentos_evaluacion?.length || 0 }} intentos</span>
              <button
                @click="exportAllEvaluacionesPDF"
                :disabled="allPdfLoading"
                class="flex items-center gap-1.5 px-3 py-1.5 bg-rose-500/10 text-rose-400 text-[9px] font-black rounded-xl hover:bg-rose-500 hover:text-white transition-all uppercase tracking-wider disabled:opacity-40"
                title="Descargar reporte completo PDF"
              >
                <span v-if="allPdfLoading" class="material-symbols-outlined text-[14px] animate-spin">sync</span>
                <span v-else class="material-symbols-outlined text-[14px]">picture_as_pdf</span>
                Exportar Todo
              </button>
            </div>
          </div>
          <div class="overflow-x-auto">
            <table class="w-full min-w-[700px] text-left border-separate border-spacing-0">
              <thead>
                <tr class="border-b border-on-surface/5">
                  <th class="px-8 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Evaluación / Curso</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Nota</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Estado</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Fecha</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">Acciones</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="intento in estudiante.intentos_evaluacion" :key="intento.id" class="group border-b border-on-surface/5 hover:bg-on-surface/[0.03] transition-colors">
                  <td class="px-8 py-5">
                    <p class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">{{ intento.evaluacion.titulo }}</p>
                    <p class="text-[10px] text-on-surface/40 font-bold mt-0.5">{{ intento.evaluacion?.curso?.titulo || '—' }}</p>
                  </td>
                  <td class="px-6 py-5">
                    <span :class="['text-sm font-black', intento.aprobado ? 'text-green-500' : 'text-red-500']">{{ Math.round(intento.nota || 0) }}%</span>
                  </td>
                  <td class="px-6 py-5">
                    <span :class="['px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest', intento.aprobado ? 'bg-green-500/10 text-green-500' : 'bg-red-500/10 text-red-500']">
                      {{ intento.aprobado ? 'Aprobado' : 'Reprobado' }}
                    </span>
                  </td>
                  <td class="px-6 py-5 text-[10px] text-on-surface/40 font-bold uppercase">{{ new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString() }}</td>
                  <td class="px-6 py-5 text-right">
                    <div class="flex items-center justify-end gap-2">
                      <button @click="showAttemptDetail(intento)" class="px-3 py-1.5 bg-accent-neon/10 text-accent-neon text-[9px] font-black rounded-lg hover:bg-accent-neon hover:text-primary transition-all uppercase tracking-wider">Ver</button>
                      <button @click="exportRowPDF(intento)" :disabled="pdfLoadingId === intento.id" class="px-3 py-1.5 bg-rose-500/10 text-rose-400 text-[9px] font-black rounded-lg hover:bg-rose-500 hover:text-white transition-all uppercase tracking-wider flex items-center gap-1 disabled:opacity-40" title="Exportar PDF">
                        <span v-if="pdfLoadingId === intento.id" class="material-symbols-outlined text-[12px] animate-spin">sync</span>
                        <span v-else class="material-symbols-outlined text-[12px]">picture_as_pdf</span>
                        PDF
                      </button>
                    </div>
                  </td>
                </tr>
                <tr v-if="!estudiante.intentos_evaluacion?.length">
                  <td colspan="5" class="px-8 py-20 text-center text-on-surface/20">
                    <span class="material-symbols-outlined text-4xl mb-3 block">quiz</span>
                    <p class="text-[10px] font-black uppercase tracking-widest">No ha realizado evaluaciones aún</p>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- Detail Attempt Modal (TELEPORTED TO BODY) -->
    <Teleport to="body">
      <div v-if="showModalDetail && selectedAttempt" class="fixed inset-0 bg-background/90 backdrop-blur-xl z-[9999] flex items-center justify-center p-4">
        <div class="bg-surface-container max-w-4xl w-full max-h-[90vh] flex flex-col rounded-[32px] overflow-hidden shadow-2xl relative border border-white/5 bg-opacity-95">
          
          <!-- Modal Header -->
          <div class="px-6 py-4 md:px-8 md:py-5 flex items-center justify-between shrink-0 bg-transparent border-b border-white/5">
            <div>
              <h3 class="text-lg md:text-xl font-black text-on-surface font-lexend tracking-tight">
                Detalle del Intento: <span class="text-gradient-neon">{{ selectedAttempt.evaluacion.titulo }}</span>
              </h3>
              <p class="text-[11px] text-on-surface/50 mt-0.5 uppercase font-bold tracking-wider">
                Realizado el {{ new Date(selectedAttempt.fecha_fin || selectedAttempt.fecha_inicio).toLocaleString() }}
              </p>
            </div>
            <button @click="closeModalDetail" class="w-9 h-9 rounded-xl bg-white/5 flex items-center justify-center text-on-surface/60 hover:bg-red-500/20 hover:text-red-400 transition-all border border-white/5">
              <span class="material-symbols-outlined text-sm">close</span>
            </button>
          </div>

          <!-- Attempt Summary Badges -->
          <div class="px-6 py-3.5 md:px-8 grid grid-cols-2 sm:grid-cols-4 gap-3 shrink-0 bg-transparent border-b border-white/5">
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">Nota obtenida</p>
              <p :class="['text-xl font-black mt-0.5', selectedAttempt.aprobado ? 'text-green-400' : 'text-red-400']">
                {{ Math.round(selectedAttempt.nota) }}%
              </p>
            </div>
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">Aprobación Mínima</p>
              <p class="text-xl font-black text-on-surface mt-0.5">
                {{ Math.round(selectedAttempt.evaluacion.nota_aprobacion) }}%
              </p>
            </div>
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner flex flex-col justify-center">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">Estado</p>
              <div>
                <span :class="['inline-block mt-1 px-2.5 py-0.5 text-[8px] font-black rounded-full uppercase tracking-widest', selectedAttempt.aprobado ? 'bg-green-500/10 text-green-400 border border-green-500/20' : 'bg-red-500/10 text-red-400 border border-red-500/20']">
                  {{ selectedAttempt.aprobado ? 'Aprobado' : 'Reprobado' }}
                </span>
              </div>
            </div>
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">Duración</p>
              <p class="text-xs font-bold text-on-surface/70 mt-1">
                {{ calculateDuration(selectedAttempt.fecha_inicio, selectedAttempt.fecha_fin) }}
              </p>
            </div>
          </div>

          <!-- Modal Content (Questions Breakdown) -->
          <div class="flex-1 overflow-y-auto p-6 md:p-8 space-y-5 custom-scrollbar bg-background/20">
            
            <!-- No answers warning -->
            <div v-if="!selectedAttempt.respuestas_seleccionadas" class="text-center py-14 bg-yellow-500/5 rounded-2xl border border-yellow-500/10">
              <span class="material-symbols-outlined text-yellow-500 text-4xl mb-3">warning</span>
              <p class="text-xs font-black text-yellow-500 uppercase tracking-widest">Detalle no disponible</p>
              <p class="text-xs text-on-surface/40 mt-2 max-w-md mx-auto">
                Este intento fue realizado antes de la actualización que guarda las respuestas seleccionadas del estudiante.
              </p>
            </div>

            <!-- Questions Breakdown -->
            <template v-else>
              <h4 class="text-xs font-black text-on-surface uppercase tracking-widest opacity-80">Desglose de preguntas</h4>
              
              <div v-for="(pregunta, qIdx) in selectedAttempt.evaluacion.preguntas" :key="pregunta.id" class="p-5 rounded-[20px] bg-surface-container border border-white/5 space-y-3 shadow-lg">
                <div class="flex items-start justify-between gap-4">
                  <div class="flex-1">
                    <span class="text-[10px] font-black text-accent-neon uppercase tracking-wider">Pregunta {{ qIdx + 1 }} ({{ pregunta.puntos }} pts)</span>
                    <h5 class="text-xs md:text-sm font-bold text-on-surface mt-0.5 leading-relaxed">{{ pregunta.pregunta }}</h5>
                  </div>
                  
                  <!-- Badge: Correct / Incorrect / No Answer -->
                  <span v-if="selectedAttempt.respuestas_seleccionadas[pregunta.id] === undefined" class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-white/5 text-on-surface/50 shrink-0 border border-white/5">
                    Sin responder
                  </span>
                  <span v-else-if="isQuestionCorrect(pregunta, selectedAttempt.respuestas_seleccionadas)" class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-green-500/10 text-green-400 flex items-center gap-1 shrink-0 border border-green-500/20">
                    <span class="material-symbols-outlined text-[10px] font-black">check</span> Correcto
                  </span>
                  <span v-else class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-red-500/10 text-red-400 flex items-center gap-1 shrink-0 border border-red-500/20">
                    <span class="material-symbols-outlined text-[10px] font-black">close</span> Incorrecto
                  </span>
                </div>

                <!-- Options Grid -->
                <div class="grid grid-cols-1 gap-2">
                  <div 
                    v-for="resp in pregunta.respuestas" 
                    :key="resp.id"
                    :class="[
                      'flex items-center gap-3 p-3 rounded-xl text-xs transition-all border',
                      (resp.es_correcta === true || resp.es_correcta == 1)
                        ? 'bg-green-500/10 border-green-500/20 text-green-300 font-bold'
                        : (Number(selectedAttempt.respuestas_seleccionadas[pregunta.id]) === Number(resp.id))
                          ? 'bg-red-500/10 border-red-500/20 text-red-300 font-bold'
                          : 'bg-background/40 border-white/5 text-on-surface/50'
                    ]"
                  >
                    <!-- Indicator icon -->
                    <span class="material-symbols-outlined text-sm font-black shrink-0" :class="[
                      (resp.es_correcta === true || resp.es_correcta == 1) ? 'text-green-400' : (Number(selectedAttempt.respuestas_seleccionadas[pregunta.id]) === Number(resp.id)) ? 'text-red-400' : 'text-on-surface/30'
                    ]">
                      {{ 
                        (resp.es_correcta === true || resp.es_correcta == 1) 
                          ? 'check_circle' 
                          : (Number(selectedAttempt.respuestas_seleccionadas[pregunta.id]) === Number(resp.id)) 
                            ? 'cancel' 
                            : 'radio_button_unchecked' 
                      }}
                    </span>
                    
                    <div class="flex-1 min-w-0">
                      {{ resp.respuesta }}
                    </div>

                    <!-- Student choice badge -->
                    <span v-if="Number(selectedAttempt.respuestas_seleccionadas[pregunta.id]) === Number(resp.id)" class="text-[8px] font-black uppercase tracking-wider bg-white/10 px-2 py-0.5 rounded text-on-surface/80 shrink-0 border border-white/5">
                      Elección del estudiante
                    </span>
                  </div>
                </div>
              </div>
            </template>

          </div>

          <!-- Modal Footer -->
          <div class="p-4 md:p-5 bg-transparent border-t border-white/5 flex justify-between items-center shrink-0">
            <div class="flex items-center gap-2 bg-background/40 p-1 rounded-xl border border-white/5 shadow-inner">
              <button @click="exportIndividualPDF" :disabled="exportStatus.individualPdf !== 'idle'" class="relative h-9 px-3 rounded-lg hover:bg-rose-500/15 text-on-surface/80 hover:text-rose-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] tracking-wider transition-all flex items-center justify-center min-w-[70px] overflow-hidden border border-white/5" title="Exportar PDF Individual">
                <div v-if="exportStatus.individualPdf === 'idle'" class="flex items-center gap-1.5 transition-all">
                  <span class="material-symbols-outlined text-[16px]">picture_as_pdf</span>
                  <span class="hidden sm:inline">PDF</span>
                </div>
                <span v-else-if="exportStatus.individualPdf === 'loading'" class="material-symbols-outlined text-[16px] animate-spin text-rose-400">sync</span>
                <span v-else-if="exportStatus.individualPdf === 'success'" class="material-symbols-outlined text-[18px] text-emerald-400 animate-bounce">check_circle</span>
              </button>
            </div>
            <button @click="closeModalDetail" class="py-2.5 px-5 rounded-xl bg-white/5 hover:bg-white/10 text-on-surface text-xs font-black uppercase tracking-wider border border-white/10 transition-all active:scale-95 shadow-lg">
              Cerrar Detalle
            </button>
          </div>

        </div>
      </div>
    </Teleport>

    <!-- Loading Overlay -->
    <div v-if="loading" class="fixed inset-0 bg-background/60 backdrop-blur-md z-[200] flex items-center justify-center">
      <div class="flex flex-col items-center gap-6">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)]"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-[0.4em]">Cargando Expediente...</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed,watch } from 'vue'
import { useRoute } from 'vue-router'
import api from '@/services/api'
import pdfMake from 'pdfmake/build/pdfmake'
import * as pdfFonts from 'pdfmake/build/vfs_fonts'

pdfMake.vfs = pdfFonts.pdfMake ? pdfFonts.pdfMake.vfs : pdfMake.vfs
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const route = useRoute()
const estudiante = ref(null)
const loading = ref(true)
const expandedGroups = ref({})
const allLogsExpanded = ref(false)

const showModalDetail = ref(false)
const exportStatus = ref({
  individualPdf: 'idle'
})
const pdfLoadingId = ref(null)
const allPdfLoading = ref(false)
const selectedAttempt = ref(null)
const certificateLoadingByCourse = ref({})

const showAttemptDetail = (intento) => {
  selectedAttempt.value = intento
  showModalDetail.value = true
}



const closeModalDetail = () => {
  showModalDetail.value = false
  selectedAttempt.value = null
}

const isQuestionCorrect = (pregunta, respuestasSeleccionadas) => {
  if (!respuestasSeleccionadas) return false
  const selectedId = respuestasSeleccionadas[pregunta.id]
  if (!selectedId) return false
  const selectedResp = pregunta.respuestas.find(r => Number(r.id) === Number(selectedId))
  return selectedResp ? (selectedResp.es_correcta === true || selectedResp.es_correcta == 1) : false
}

const calculateDuration = (start, end) => {
  if (!start || !end) return 'N/A'
  const startTime = new Date(start)
  const endTime = new Date(end)
  const diffMs = endTime - startTime
  if (isNaN(diffMs) || diffMs < 0) return 'N/A'
  const diffSecs = Math.floor(diffMs / 1000)
  const mins = Math.floor(diffSecs / 60)
  const secs = diffSecs % 60
  if (mins === 0) return `${secs}s`
  return `${mins}m ${secs}s`
}

const toggleLogGroup = (date) => {
  expandedGroups.value[date] = !expandedGroups.value[date]
}

const toggleAllLogs = () => {
  allLogsExpanded.value = !allLogsExpanded.value
  Object.keys(logsAgrupados.value).forEach(date => {
    expandedGroups.value[date] = allLogsExpanded.value
  })
}

const getDeviceIcon = (os) => {
  const osLower = os?.toLowerCase() || ''
  if (osLower.includes('windows')) return 'desktop_windows'
  if (osLower.includes('android')) return 'phone_android'
  if (osLower.includes('ios') || osLower.includes('iphone') || osLower.includes('ipad')) return 'phone_iphone'
  if (osLower.includes('mac')) return 'desktop_mac'
  if (osLower.includes('linux')) return 'terminal'
  return 'devices'
}

const liberateDevices = async () => {
  modalStore.openModal({
    title: '¿Liberar Cuenta?',
    message: 'Se desvincularán todos los dispositivos actuales. El estudiante podrá registrar uno nuevo al iniciar sesión.',
    confirmText: 'Liberar Ahora',
    type: 'warning',
    onConfirm: async () => {
      try {
        loading.value = true
        await api.patch(`/dispositivos-usuario/liberate/${estudiante.value.id}`)
        notificationStore.addNotification({
          title: 'Cuenta Liberada',
          message: 'Los dispositivos han sido desvinculados exitosamente.',
          type: 'success'
        })
        await fetchEstudiante()
      } catch (error) {
        console.error('Error liberating devices:', error)
        notificationStore.addNotification({
          title: 'Error de Seguridad',
          message: 'No se pudo completar la desvinculación.',
          type: 'error'
        })
      } finally {
        loading.value = false
      }
    }
  })
}

const logsAgrupados = computed(() => {
  if (!estudiante.value?.auditoria_logs) return {}
  
  const sortedLogs = [...estudiante.value.auditoria_logs].sort((a, b) => 
    new Date(b.fecha_creacion) - new Date(a.fecha_creacion)
  )

  const groups = {}
  sortedLogs.forEach(log => {
    const date = new Date(log.fecha_creacion).toLocaleDateString('es-BO', { 
      day: '2-digit', 
      month: 'short', 
      year: 'numeric' 
    })
    if (!groups[date]) {
      groups[date] = []
      // Inicializar como expandido si es el primer día o si ya estaba expandido
      if (Object.keys(groups).length === 1 || allLogsExpanded.value) {
        expandedGroups.value[date] = true
      }
    }
    groups[date].push(log)
  })
  return groups
})


const correctCount = computed(() => {
  if (!selectedAttempt.value?.respuestas_seleccionadas || !selectedAttempt.value?.evaluacion?.preguntas) return 0
  return selectedAttempt.value.evaluacion.preguntas.filter(p =>
    isQuestionCorrect(p, selectedAttempt.value.respuestas_seleccionadas)
  ).length
})

watch(() => showModalDetail.value, (isOpen) => {
  if (isOpen) {
    document.body.style.overflow = 'hidden';
  } else {
    document.body.style.overflow = '';
  }
});

const loadLogoToPngBase64 = (url) => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.crossOrigin = 'Anonymous';
    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = img.width;
      canvas.height = img.height;
      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0);
      resolve(canvas.toDataURL('image/png'));
    };
    img.onerror = (e) => reject(e);
    img.src = url;
  });
};

const exportIndividualPDF = async () => {
  if (!selectedAttempt.value || exportStatus.value.individualPdf !== 'idle') return;
  
  exportStatus.value.individualPdf = 'loading';

  try {
    let logoDataUrl = null;
    try {
      logoDataUrl = await loadLogoToPngBase64('/logo-dark.webp');
    } catch (e) {
      console.warn("No se pudo cargar logo", e);
    }

    const headerColumns = [];
    if (logoDataUrl) {
      headerColumns.push({ image: logoDataUrl, width: 130, alignment: 'left' });
    } else {
      headerColumns.push({ text: 'ENERVIDA', fontSize: 16, bold: true, color: '#2C3E50', alignment: 'left' });
    }

    headerColumns.push({
      width: '*',
      stack: [
        { text: 'REPORTE DE CALIFICACIÓN', style: 'pdfTitle' },
        { text: 'DOCUMENTO ACADÉMICO OFICIAL', style: 'pdfSubtitle' },
        { text: `Fecha de emisión: ${new Date().toLocaleDateString('es-BO')}`, style: 'pdfDate' }
      ],
      alignment: 'right',
      margin: [0, logoDataUrl ? 10 : 0, 0, 0]
    });

    const intento = selectedAttempt.value;
    const notaFinal = Math.round(intento.nota || 0) + '%';
    const notaMinima = Math.round(intento.evaluacion?.nota_aprobacion || 0) + '%';
    const estado = intento.aprobado ? 'APROBADO' : 'REPROBADO';
    const colorEstado = intento.aprobado ? '#27AE60' : '#E74C3C';
    
    const correctas = correctCount.value;
    const totalPreguntas = intento.evaluacion?.preguntas?.length || 0;

    const docDefinition = {
      pageSize: 'A4',
      pageOrientation: 'portrait',
      pageMargins: [40, 45, 40, 45],
      content: [
        { columns: headerColumns },
        { canvas: [{ type: 'line', x1: 0, y1: 12, x2: 515, y2: 12, lineWidth: 1.5, lineColor: '#2C3E50' }] },
        { text: '', margin: [0, 0, 0, 25] },
        
        // Datos del Estudiante y Curso
        {
          style: 'tableExample',
          table: {
            widths: ['50%', '50%'],
            body: [
              [
                { text: 'Estudiante', style: 'tableHeader' },
                { text: 'Curso / Evaluación', style: 'tableHeader' }
              ],
              [
                { stack: [
                  { text: `${estudiante.value?.nombres || ''} ${estudiante.value?.apellidos || ''}`, bold: true },
                  { text: estudiante.value?.correo || '', color: '#7F8C8D', fontSize: 10 }
                ]},
                { stack: [
                  { text: intento.evaluacion?.curso?.titulo || '—', bold: true },
                  { text: intento.evaluacion?.titulo || '', color: '#7F8C8D', fontSize: 10 }
                ]}
              ],
              [
                { text: 'Fecha del Intento', style: 'tableHeader' },
                { text: 'Duración', style: 'tableHeader' }
              ],
              [
                { text: new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString('es-BO', { day: '2-digit', month: 'short', year: 'numeric' }), bold: true },
                { text: calculateDuration(intento.fecha_inicio, intento.fecha_fin), bold: true }
              ]
            ]
          },
          layout: 'lightHorizontalLines'
        },
        { text: '', margin: [0, 0, 0, 20] },
        
        // Resumen de Calificación
        {
          table: {
            widths: ['*', '*', '*'],
            body: [
              [
                { text: 'Nota Final', style: 'metricLabel' },
                { text: 'Nota Mínima', style: 'metricLabel' },
                { text: 'Estado', style: 'metricLabel' }
              ],
              [
                { text: notaFinal, style: 'metricValue', color: colorEstado },
                { text: notaMinima, style: 'metricValue' },
                { text: estado, style: 'metricValue', color: colorEstado }
              ]
            ]
          },
          layout: {
            defaultBorder: false,
            fillColor: function (rowIndex) {
              return rowIndex === 0 ? '#F8F9FA' : null;
            }
          },
          margin: [0, 0, 0, 30]
        },
        
        // Detalles de la evaluación
        { text: 'Detalles Estadísticos', style: 'sectionTitle' },
        {
          table: {
            widths: ['*', '*'],
            body: [
              [
                { text: 'Métrica', style: 'tableHeader' },
                { text: 'Resultado', style: 'tableHeader', alignment: 'right' }
              ],
              [ 'Preguntas Correctas', { text: `${correctas} / ${totalPreguntas}`, alignment: 'right', bold: true } ],
              [ 'Porcentaje Obtenido', { text: notaFinal, alignment: 'right', bold: true } ],
              [ 'Resultado Académico', { text: estado, alignment: 'right', bold: true, color: colorEstado } ]
            ]
          },
          layout: 'lightHorizontalLines',
          margin: [0, 0, 0, 60]
        },
        
        // Firmas
        {
          columns: [
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma del Estudiante', bold: true, margin: [0, 5, 0, 0] },
                { text: 'CI / Identificación', fontSize: 9, color: '#7F8C8D' }
              ],
              alignment: 'center'
            },
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma Autorizada', bold: true, margin: [0, 5, 0, 0] },
                { text: 'Director Académico', fontSize: 9, color: '#7F8C8D' }
              ],
              alignment: 'center'
            }
          ]
        }
      ],
      styles: {
        pdfTitle: { fontSize: 16, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 11, bold: true, color: '#2980B9', margin: [0, 2, 0, 2] },
        pdfDate: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 9, bold: true, color: '#7F8C8D', margin: [0, 5, 0, 5] },
        metricLabel: { fontSize: 9, bold: true, color: '#7F8C8D', alignment: 'center', margin: [0, 10, 0, 5] },
        metricValue: { fontSize: 24, bold: true, color: '#2C3E50', alignment: 'center', margin: [0, 5, 0, 15] },
        sectionTitle: { fontSize: 12, bold: true, color: '#2C3E50', margin: [0, 0, 0, 10] }
      },
      footer: (currentPage, pageCount) => {
        return {
          columns: [
            { text: 'Este documento es un reporte de control académico interno.', alignment: 'left', fontSize: 8, color: '#95A5A6' },
            { text: `Página ${currentPage} de ${pageCount}`, alignment: 'right', fontSize: 8, color: '#95A5A6' }
          ],
          margin: [40, 0, 40, 0]
        };
      }
    };

    exportStatus.value.individualPdf = 'success';
    
    setTimeout(() => {
      pdfMake.createPdf(docDefinition).download(`Boleta_Calificacion_${estudiante.value?.nombres || 'Estudiante'}.pdf`);
      setTimeout(() => {
        exportStatus.value.individualPdf = 'idle';
      }, 500);
    }, 1200);

  } catch (error) {
    console.error("Error al exportar PDF individual:", error);
    exportStatus.value.individualPdf = 'idle';
  }
};
const exportRowPDF = async (intento) => {
  if (pdfLoadingId.value) return;
  pdfLoadingId.value = intento.id;
  try {
    let logoDataUrl = null;
    try { logoDataUrl = await loadLogoToPngBase64('/logo-dark.webp'); } catch(e) {}
    const headerColumns = [];
    if (logoDataUrl) {
      headerColumns.push({ image: logoDataUrl, width: 130, alignment: 'left' });
    } else {
      headerColumns.push({ text: 'ENERVIDA', fontSize: 16, bold: true, color: '#2C3E50' });
    }
    headerColumns.push({
      width: '*',
      stack: [
        { text: 'REPORTE DE CALIFICACIÓN', style: 'pdfTitle' },
        { text: 'DOCUMENTO ACADÉMICO OFICIAL', style: 'pdfSubtitle' },
        { text: `Fecha de emisión: ${new Date().toLocaleDateString('es-BO')}`, style: 'pdfDate' }
      ],
      alignment: 'right', margin: [0, logoDataUrl ? 10 : 0, 0, 0]
    });
    const nota = Math.round(intento.nota || 0) + '%';
    const notaMin = Math.round(intento.evaluacion?.nota_aprobacion || 0) + '%';
    const estado = intento.aprobado ? 'APROBADO' : 'REPROBADO';
    const colorEstado = intento.aprobado ? '#27AE60' : '#E74C3C';
    const docDefinition = {
      pageSize: 'A4', pageOrientation: 'portrait', pageMargins: [40, 45, 40, 45],
      content: [
        { columns: headerColumns },
        { canvas: [{ type: 'line', x1: 0, y1: 12, x2: 515, y2: 12, lineWidth: 1.5, lineColor: '#2C3E50' }] },
        { text: '', margin: [0, 0, 0, 25] },
        {
          table: {
            widths: ['50%', '50%'],
            body: [
              [{ text: 'Estudiante', style: 'tableHeader' }, { text: 'Curso / Evaluación', style: 'tableHeader' }],
              [
                { stack: [{ text: `${estudiante.value?.nombres || ''} ${estudiante.value?.apellidos || ''}`, bold: true }, { text: estudiante.value?.correo || '', color: '#7F8C8D', fontSize: 10 }] },
                { stack: [{ text: intento.evaluacion?.curso?.titulo || '—', bold: true }, { text: intento.evaluacion?.titulo || '', color: '#7F8C8D', fontSize: 10 }] }
              ],
              [{ text: 'Fecha del Intento', style: 'tableHeader' }, { text: 'Duración', style: 'tableHeader' }],
              [
                { text: new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString('es-BO', { day: '2-digit', month: 'short', year: 'numeric' }), bold: true },
                { text: calculateDuration(intento.fecha_inicio, intento.fecha_fin), bold: true }
              ]
            ]
          }, layout: 'lightHorizontalLines'
        },
        { text: '', margin: [0, 0, 0, 20] },
        {
          table: {
            widths: ['*', '*', '*'],
            body: [
              [{ text: 'Nota Final', style: 'metricLabel' }, { text: 'Nota Mínima', style: 'metricLabel' }, { text: 'Estado', style: 'metricLabel' }],
              [{ text: nota, style: 'metricValue', color: colorEstado }, { text: notaMin, style: 'metricValue' }, { text: estado, style: 'metricValue', color: colorEstado }]
            ]
          },
          layout: { defaultBorder: false, fillColor: (r) => r === 0 ? '#F8F9FA' : null },
          margin: [0, 0, 0, 60]
        },
        {
          columns: [
            { stack: [{ canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] }, { text: 'Firma del Estudiante', bold: true, margin: [0, 5, 0, 0] }, { text: 'CI / Identificación', fontSize: 9, color: '#7F8C8D' }], alignment: 'center' },
            { stack: [{ canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] }, { text: 'Firma Autorizada', bold: true, margin: [0, 5, 0, 0] }, { text: 'Director Académico', fontSize: 9, color: '#7F8C8D' }], alignment: 'center' }
          ]
        }
      ],
      styles: {
        pdfTitle: { fontSize: 16, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 11, bold: true, color: '#2980B9', margin: [0, 2, 0, 2] },
        pdfDate: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 9, bold: true, color: '#7F8C8D', margin: [0, 5, 0, 5] },
        metricLabel: { fontSize: 9, bold: true, color: '#7F8C8D', alignment: 'center', margin: [0, 10, 0, 5] },
        metricValue: { fontSize: 24, bold: true, color: '#2C3E50', alignment: 'center', margin: [0, 5, 0, 15] }
      },
      footer: (currentPage, pageCount) => ({ columns: [{ text: 'Reporte de control académico interno.', alignment: 'left', fontSize: 8, color: '#95A5A6' }, { text: `Página ${currentPage} de ${pageCount}`, alignment: 'right', fontSize: 8, color: '#95A5A6' }], margin: [40, 0, 40, 0] })
    };
    pdfMake.createPdf(docDefinition).download(`Boleta_${estudiante.value?.nombres || 'Estudiante'}_${intento.evaluacion?.titulo || ''}.pdf`);
  } catch(e) {
    console.error('Error PDF:', e);
  } finally {
    pdfLoadingId.value = null;
  }
};


const exportAllEvaluacionesPDF = async () => {
  if (allPdfLoading.value || !estudiante.value?.intentos_evaluacion?.length) return
  allPdfLoading.value = true
  try {
    let logoDataUrl = null
    try { logoDataUrl = await loadLogoToPngBase64('/logo-dark.webp') } catch(e) {}

    const headerCols = []
    if (logoDataUrl) {
      headerCols.push({ image: logoDataUrl, width: 120, alignment: 'left' })
    } else {
      headerCols.push({ text: 'ENERVIDA', fontSize: 16, bold: true, color: '#2C3E50' })
    }
    headerCols.push({
      width: '*',
      stack: [
        { text: 'HISTORIAL COMPLETO DE EVALUACIONES', style: 'pdfTitle' },
        { text: `${estudiante.value.nombres} ${estudiante.value.apellidos}`, style: 'pdfSubtitle' },
        { text: `Fecha de emisión: ${new Date().toLocaleDateString('es-BO')}`, style: 'pdfDate' }
      ],
      alignment: 'right', margin: [0, logoDataUrl ? 8 : 0, 0, 0]
    })

    const tableBody = [[
      { text: 'EVALUACIÓN', style: 'tableHeader' },
      { text: 'CURSO', style: 'tableHeader' },
      { text: 'NOTA', style: 'tableHeader', alignment: 'center' },
      { text: 'ESTADO', style: 'tableHeader', alignment: 'center' },
      { text: 'DURACIÓN', style: 'tableHeader', alignment: 'center' },
      { text: 'FECHA', style: 'tableHeader', alignment: 'center' }
    ]]

    for (const i of estudiante.value.intentos_evaluacion) {
      const aprobado = i.aprobado
      const color = aprobado ? '#27AE60' : '#E74C3C'
      tableBody.push([
        { text: i.evaluacion?.titulo || '—', fontSize: 9, bold: true },
        { text: i.evaluacion?.curso?.titulo || '—', fontSize: 9, color: '#7F8C8D' },
        { text: Math.round(i.nota || 0) + '%', fontSize: 9, bold: true, alignment: 'center', color },
        { text: aprobado ? 'Aprobado' : 'Reprobado', fontSize: 9, bold: true, alignment: 'center', color },
        { text: calculateDuration(i.fecha_inicio, i.fecha_fin), fontSize: 9, alignment: 'center' },
        { text: new Date(i.fecha_fin || i.fecha_inicio).toLocaleDateString('es-BO', { day: '2-digit', month: 'short', year: 'numeric' }), fontSize: 9, alignment: 'center' }
      ])
    }

    const aprobados = estudiante.value.intentos_evaluacion.filter(i => i.aprobado).length
    const total = estudiante.value.intentos_evaluacion.length

    const docDef = {
      pageSize: 'A4', pageOrientation: 'landscape', pageMargins: [40, 45, 40, 45],
      content: [
        { columns: headerCols },
        { canvas: [{ type: 'line', x1: 0, y1: 12, x2: 762, y2: 12, lineWidth: 1.5, lineColor: '#2C3E50' }] },
        { text: '', margin: [0, 0, 0, 20] },
        // Resumen del estudiante
        {
          columns: [
            { stack: [{ text: 'Correo', style: 'metaLabel' }, { text: estudiante.value.correo || '—', style: 'metaValue' }] },
            { stack: [{ text: 'Total Intentos', style: 'metaLabel' }, { text: String(total), style: 'metaValue' }] },
            { stack: [{ text: 'Aprobados', style: 'metaLabel' }, { text: String(aprobados), style: 'metaValue', color: '#27AE60' }] },
            { stack: [{ text: 'Reprobados', style: 'metaLabel' }, { text: String(total - aprobados), style: 'metaValue', color: '#E74C3C' }] }
          ],
          margin: [0, 0, 0, 20]
        },
        {
          table: { headerRows: 1, widths: ['*', '*', 'auto', 'auto', 'auto', 'auto'], body: tableBody },
          layout: {
            fillColor: (r) => r === 0 ? '#F8F9FA' : null,
            hLineWidth: (i, node) => (i === 0 || i === node.table.body.length) ? 1 : 0.5,
            vLineWidth: () => 0,
            hLineColor: () => '#E0E0E0',
            paddingTop: () => 5, paddingBottom: () => 5
          }
        }
      ],
      styles: {
        pdfTitle: { fontSize: 14, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 11, bold: true, color: '#2980B9', margin: [0, 2, 0, 2] },
        pdfDate: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 9, bold: true, color: '#2C3E50', margin: [0, 5, 0, 5] },
        metaLabel: { fontSize: 8, bold: true, color: '#7F8C8D', margin: [0, 0, 0, 2] },
        metaValue: { fontSize: 11, bold: true, color: '#2C3E50' }
      },
      footer: (currentPage, pageCount) => ({
        columns: [
          { text: 'Generado por Enervida LMS', alignment: 'left', fontSize: 8, color: '#95A5A6' },
          { text: `Página ${currentPage} de ${pageCount}`, alignment: 'right', fontSize: 8, color: '#95A5A6' }
        ],
        margin: [40, 0, 40, 0]
      })
    }
    pdfMake.createPdf(docDef).download(`Historial_Evaluaciones_${estudiante.value.nombres}_${estudiante.value.apellidos}.pdf`)
  } catch(e) {
    console.error('Error PDF all:', e)
  } finally {
    allPdfLoading.value = false
  }
}

const fetchEstudiante = async () => {
  loading.value = true
  try {
    const res = await api.get(`/usuarios/${route.params.id}`)
    estudiante.value = res.data
  } catch (error) {
    console.error('Error fetching student detail:', error)
  } finally {
    loading.value = false
  }
}

const hasCertificateForCourse = (cursoId) => {
  if (!estudiante.value?.certificados?.length) return false
  return estudiante.value.certificados.some(cert => Number(cert.curso_id) === Number(cursoId))
}

const hasApprovedAttemptForCourse = (cursoId) => {
  if (!estudiante.value?.intentos_evaluacion?.length) return false
  return estudiante.value.intentos_evaluacion.some(intento => {
    return Number(intento.evaluacion?.curso?.id) === Number(cursoId) && intento.aprobado
  })
}

const downloadCertificateById = async (certId, courseTitle = 'Certificado') => {
  const response = await api.get(`/certificados/${certId}/download`, { responseType: 'blob' })
  const url = window.URL.createObjectURL(new Blob([response.data]))
  const link = document.createElement('a')
  link.href = url
  link.setAttribute('download', `Certificado-${courseTitle || certId}.pdf`)
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
  window.URL.revokeObjectURL(url)
}

const emitirCertificadoCurso = async (cursoId, cursoTitulo, force = false) => {
  if (!estudiante.value?.id) return

  certificateLoadingByCourse.value[cursoId] = true

  try {
    const response = await api.post('/certificados/emitir', {
      usuario_id: estudiante.value.id,
      curso_id: cursoId,
      force,
    })

    const certificado = response.data?.certificado
    if (!certificado?.id) {
      throw new Error('No se obtuvo el certificado generado')
    }

    await downloadCertificateById(certificado.id, cursoTitulo)
    notificationStore.addNotification({
      title: 'Certificado listo',
      message: response.data?.created
        ? force
          ? 'Certificado emitido manualmente y descargado correctamente.'
          : 'El certificado fue emitido y se descargó correctamente.'
        : 'Se reemitió el certificado correctamente.',
      type: 'success',
    })

    await fetchEstudiante()
  } catch (error) {
    console.error('Error emitting certificate:', error)
    notificationStore.addNotification({
      title: 'No se pudo emitir el certificado',
      message: error?.response?.data?.message || 'El estudiante no tiene una evaluación aprobada para este curso.',
      type: 'error',
    })
  } finally {
    certificateLoadingByCourse.value[cursoId] = false
  }
}

const toggleStatus = async () => {
  try {
    const newStatus = estudiante.value.estado === 'ACTIVO' ? 'INACTIVO' : 'ACTIVO'
    await api.patch(`/usuarios/${estudiante.value.id}`, { estado: newStatus })
    estudiante.value.estado = newStatus
  } catch (error) {
    console.error('Error toggling status:', error)
  }
}

const approveEnrollment = async (inscripcionId) => {
  modalStore.openModal({
    title: '¿Confirmar Pago?',
    message: '¿El estudiante ha realizado el pago correctamente para activar este curso?',
    confirmText: 'Sí, Activar',
    type: 'success',
    onConfirm: async () => {
      try {
        await api.patch(`/inscripciones/${inscripcionId}`, { estado: 'ACTIVO' })
        notificationStore.addNotification({
          title: 'Inscripción Activada',
          message: 'El estudiante ya tiene acceso total al curso.',
          type: 'success'
        })
        fetchEstudiante()
      } catch (error) {
        console.error('Error approving enrollment:', error)
        notificationStore.addNotification({
          title: 'Error de Activación',
          message: 'No se pudo procesar la aprobación del curso.',
          type: 'error'
        })
      }
    }
  })
}

const getImageUrl = (url) => {
  if (!url) return null;
  if (url.startsWith('http')) return url;
  const baseUrl = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '');
  const cleanUrl = url.startsWith('/') ? url : `/${url}`;
  return `${baseUrl}${cleanUrl}`;
};

onMounted(() => {
  fetchEstudiante()
})
</script>
