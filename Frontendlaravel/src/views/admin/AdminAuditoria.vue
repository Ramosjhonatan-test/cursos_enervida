<template>
  <div class="space-y-8 animate-fade-in text-on-surface pb-20">
    <!-- Header & Hero -->
    <div class="panel-hero p-10 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none">
      <div class="absolute -right-20 -top-20 w-80 h-80 bg-accent-neon/10 rounded-full blur-[100px] group-hover:bg-accent-neon/20 transition-all duration-1000"></div>
      <div class="absolute -left-20 -bottom-20 w-64 h-64 bg-primary/5 rounded-full blur-[80px]"></div>
      
      <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative z-10">
        <div class="flex-1">
          <div class="flex items-center gap-4 mb-3">
            <div class="w-16 h-16 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon shadow-neon-sm animate-pulse-slow">
              <span class="material-symbols-outlined text-4xl">policy</span>
            </div>
            <div>
              <h2 class="text-lg md:text-xl font-bold text-on-surface font-lexend tracking-tight leading-none">
                Auditoría
              </h2>
              <p class="text-on-surface/50 text-[10px] font-bold uppercase tracking-[0.3em] mt-3 flex items-center gap-2">
                <span class="flex h-1.5 w-1.5 relative">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-1.5 w-1.5 bg-accent-neon"></span>
                </span>
                SISTEMA DE TRAZABILIDAD PROACTIVA
              </p>
            </div>
          </div>
        </div>
        
        <div class="flex flex-wrap items-center gap-4">
          <!-- Activity Chart Mini -->
          <div class="hidden xl:flex items-end gap-1.5 h-12 px-6">
            <div v-for="day in activityChart" :key="day.date" 
                 class="w-2 bg-accent-neon/20 rounded-full transition-all hover:bg-accent-neon hover:shadow-neon-sm relative group/bar"
                 :style="{ height: Math.max(day.height, 10) + '%' }">
              <div class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-2 py-1 bg-black text-[8px] font-black text-white rounded opacity-0 group-hover/bar:opacity-100 transition-opacity whitespace-nowrap z-50">
                {{ day.count }} eventos
              </div>
            </div>
          </div>

          <div class="flex gap-3">
            <button @click="fetchLogs" class="btn-premium glass-card gap-2 !py-4 px-8 group/btn relative overflow-hidden">
              <div class="absolute inset-0 bg-accent-neon/5 translate-y-full group-hover/btn:translate-y-0 transition-transform"></div>
              <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative" :class="{ 'animate-spin': loading }">refresh</span>
              <span class="relative">Sincronizar</span>
            </button>
            <button @click="confirmClearAll" class="btn-premium bg-red-500/10 text-red-500 hover:bg-red-500 hover:text-white shadow-sm hover:shadow-red-500/20 transition-all !py-4 gap-2 px-6 !border-none">
              <span class="material-symbols-outlined text-lg">delete_sweep</span>
              Limpiar Bitácora
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Stats -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-6">
      <div class="glass-card rounded-[40px] p-8 relative overflow-hidden group hover:-translate-y-1 transition-all duration-500 !border-none bg-on-surface/[0.03]">
        <div class="absolute top-0 right-0 p-4 opacity-5 group-hover:opacity-10 transition-opacity">
          <span class="material-symbols-outlined text-7xl">database</span>
        </div>
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Total Eventos</p>
          <div class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover:shadow-neon-sm transition-all">
            <span class="material-symbols-outlined text-xl">insights</span>
          </div>
        </div>
        <p class="text-5xl font-black text-on-surface font-lexend tracking-tight">{{ totalLogs }}</p>
        <div class="mt-6 flex items-center gap-3">
          <span class="text-[10px] font-black text-accent-neon bg-accent-neon/10 px-3 py-1 rounded-full italic">Global</span>
          <div class="flex-1 h-1.5 bg-on-surface/5 rounded-full overflow-hidden">
            <div class="h-full bg-accent-neon animate-pulse-slow" :style="{ width: Math.min((totalLogs/1000)*100, 100) + '%' }"></div>
          </div>
        </div>
      </div>

      <!-- Creations -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 !border-none bg-on-surface/[0.03]">
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Creaciones</p>
          <div class="w-10 h-10 rounded-xl bg-green-500/10 flex items-center justify-center text-green-500 group-hover:shadow-[0_0_15px_rgba(34,197,94,0.2)] transition-all">
            <span class="material-symbols-outlined text-xl">add_circle</span>
          </div>
        </div>
        <p class="text-5xl font-black text-green-500 font-lexend tracking-tight">{{ stats.creations }}</p>
        <div class="mt-6 flex items-center gap-2 text-[10px] font-black uppercase text-green-500/60">
          <span class="material-symbols-outlined text-sm">trending_up</span>
          <span>+{{ stats.creationsToday }} hoy</span>
        </div>
      </div>

      <!-- Ediciones -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 !border-none bg-on-surface/[0.03]">
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Ediciones</p>
          <div class="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 group-hover:shadow-[0_0_15px_rgba(59,130,246,0.2)] transition-all">
            <span class="material-symbols-outlined text-xl">edit_square</span>
          </div>
        </div>
        <p class="text-5xl font-black text-blue-500 font-lexend tracking-tight">{{ stats.updates }}</p>
        <div class="mt-6 flex items-center gap-2 text-[10px] font-black uppercase text-blue-500/60">
          <div class="w-full bg-on-surface/5 h-1.5 rounded-full overflow-hidden">
             <div class="h-full bg-blue-500" :style="{ width: stats.updatesPct + '%' }"></div>
          </div>
          <span class="whitespace-nowrap">{{ stats.updatesPct }}%</span>
        </div>
      </div>

      <!-- Deletions -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 relative overflow-hidden !border-none bg-on-surface/[0.03]">
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Eliminaciones</p>
          <div class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 group-hover:shadow-[0_0_15px_rgba(239,68,68,0.2)] transition-all">
            <span class="material-symbols-outlined text-xl">delete_forever</span>
          </div>
        </div>
        <p class="text-5xl font-black text-red-500 font-lexend tracking-tight">{{ stats.deletions }}</p>
        <div class="mt-6 flex items-center gap-2 text-[10px] font-black uppercase text-red-500/40">
          <span class="material-symbols-outlined text-sm">warning</span>
          <span>Acciones Irreversibles</span>
        </div>
      </div>

      <!-- Top Actor -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 relative overflow-hidden !border-none bg-on-surface/[0.03]">
        <div class="absolute -right-4 -bottom-4 opacity-5 group-hover:opacity-10 transition-opacity">
          <span class="material-symbols-outlined text-7xl text-purple-500">person</span>
        </div>
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Top Actor</p>
          <div class="w-10 h-10 rounded-xl bg-purple-500/10 flex items-center justify-center text-purple-500">
            <span class="material-symbols-outlined text-xl">stars</span>
          </div>
        </div>
        <p class="text-lg font-black text-on-surface font-lexend tracking-tight line-clamp-1 mb-1">{{ topStats.topUser[0] }}</p>
        <p class="text-[10px] font-black text-purple-500/60 uppercase tracking-tight">{{ topStats.topUser[1] }} acciones</p>
      </div>

      <!-- Top Entity -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 relative overflow-hidden !border-none bg-on-surface/[0.03]">
        <div class="absolute -right-4 -bottom-4 opacity-5 group-hover:opacity-10 transition-opacity">
          <span class="material-symbols-outlined text-7xl text-orange-500">inventory_2</span>
        </div>
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Foco de Cambio</p>
          <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center text-orange-500">
            <span class="material-symbols-outlined text-xl">account_tree</span>
          </div>
        </div>
        <p class="text-xl font-black text-on-surface font-lexend tracking-tight uppercase line-clamp-1">{{ topStats.topEntity[0] }}</p>
        <p class="text-[10px] font-black text-orange-500/60 uppercase tracking-tight">{{ topStats.topEntity[1] }} mutaciones</p>
      </div>
    </div>

    <!-- Filters Bar -->
    <div class="glass-card rounded-[40px] p-8 flex flex-col xl:flex-row gap-8 items-center justify-between relative overflow-visible">
      <div class="absolute left-0 top-0 bottom-0 w-1 bg-accent-neon/30"></div>
      
      <div ref="filterBarRef" class="flex flex-col md:flex-row gap-5 w-full xl:max-w-4xl">
        <div class="relative flex-1 group">
          <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-on-surface/20 group-focus-within:text-accent-neon transition-all scale-110">search</span>
          <input 
            v-model="searchQuery" 
            type="text" 
            placeholder="Buscar acción, usuario, ID o descripción..." 
            class="input-cyber w-full !pl-14 !py-5 transition-all text-sm font-medium border-none bg-on-surface/[0.04]"
          />
        </div>

        <button 
          @click="toggleDatePicker" 
          class="btn-premium gap-3 !px-8 min-w-[220px] justify-between group !bg-on-surface/[0.06] border-none shadow-none"
          :class="{ 'bg-accent-neon !text-black': hasDateFilter }"
        >
          <div class="flex items-center gap-2">
            <span class="material-symbols-outlined text-lg">calendar_month</span>
            <span class="text-xs font-black uppercase tracking-widest">Mostrar por Fecha</span>
          </div>
          <span class="material-symbols-outlined text-sm transition-transform group-hover:rotate-180" :class="{ 'rotate-180': showDatePicker }">expand_more</span>
        </button>
      </div>

      <div class="flex flex-wrap items-center gap-5 w-full xl:w-auto">
        <!-- Quick Filters -->
        <div class="flex items-center gap-2 p-1.5 bg-on-surface/[0.03] rounded-2xl shadow-inner">
          <button 
            @click="setQuickDate('today')" 
            class="px-5 py-2.5 text-[10px] font-black uppercase tracking-widest rounded-xl transition-all"
            :class="isQuickDateActive('today') ? 'bg-accent-neon text-black shadow-neon-sm' : 'text-on-surface/40 hover:bg-on-surface/10'"
          >
            Hoy
          </button>
          <button 
            @click="setQuickDate('week')" 
            class="px-5 py-2.5 text-[10px] font-black uppercase tracking-widest rounded-xl transition-all"
            :class="isQuickDateActive('week') ? 'bg-accent-neon text-black shadow-neon-sm' : 'text-on-surface/40 hover:bg-on-surface/10'"
          >
            Semana
          </button>
          <button 
            @click="setQuickDate('month')" 
            class="px-5 py-2.5 text-[10px] font-black uppercase tracking-widest rounded-xl transition-all"
            :class="isQuickDateActive('month') ? 'bg-accent-neon text-black shadow-neon-sm' : 'text-on-surface/40 hover:bg-on-surface/10'"
          >
            Mes
          </button>
        </div>
        
        <div class="w-px h-8 bg-on-surface/10 hidden xl:block"></div>
        
        <!-- Exportar Excel -->
        <button @click="exportToExcel" :disabled="exportStatus.excel !== 'idle'" class="btn-icon-premium hover:bg-blue-500 hover:text-white" title="Exportar Excel">
          <span v-if="exportStatus.excel === 'idle'" class="material-symbols-outlined text-lg">download</span>
          <span v-else-if="exportStatus.excel === 'loading'" class="material-symbols-outlined text-[18px] animate-spin text-rose-400">sync</span>
          <span v-else-if="exportStatus.excel === 'success'" class="material-symbols-outlined text-[22px] animate-bounce text-emerald-400">check_circle</span>
        </button>

        <!-- Exportar PDF -->
        <button @click="exportToPDF" :disabled="exportStatus.pdf !== 'idle'" class="btn-icon-premium hover:bg-blue-500 hover:text-white" title="Exportar PDF">
          <div v-if="exportStatus.pdf === 'idle'" class="flex items-center gap-1.5 transition-all">
            <span class="material-symbols-outlined text-lg">picture_as_pdf</span>
          </div>
          <span v-else-if="exportStatus.pdf === 'loading'" class="material-symbols-outlined text-[18px] animate-spin text-rose-400">sync</span>
          <span v-else-if="exportStatus.pdf === 'success'" class="material-symbols-outlined text-[22px] text-emerald-400 animate-bounce">check_circle</span>
        </button>
        <button 
          v-if="logs.length > 0"
          @click="confirmClearAll" 
          class="btn-icon-premium hover:bg-red-500 hover:text-white group" 
          title="Limpiar todos los Logs"
        >
          <span class="material-symbols-outlined text-lg group-hover:animate-pulse">delete_sweep</span>
        </button>

        <button 
          v-if="hasFilters" 
          @click="resetFilters" 
          class="flex items-center gap-2 text-[10px] font-black text-red-500 uppercase tracking-widest hover:bg-red-500/10 px-6 py-4 rounded-2xl transition-all group"
        >
          <span class="material-symbols-outlined text-sm transition-transform group-hover:rotate-90">filter_list_off</span>
          Limpiar Filtros
        </button>
      </div>

      <!-- Expandable Date Picker -->
      <teleport to="body">
        <transition 
          enter-active-class="transition duration-300 ease-out"
          enter-from-class="transform -translate-y-4 opacity-0"
          enter-to-class="transform translate-y-0 opacity-100"
          leave-active-class="transition duration-200 ease-in"
          leave-from-class="transform translate-y-0 opacity-100"
          leave-to-class="transform -translate-y-4 opacity-0"
        >
          <div v-if="showDatePicker" :style="datePickerStyle" class="glass-card-premium p-6 shadow-[0_20px_50px_rgba(0,0,0,0.5)] rounded-[20px] border-none">
            <div class="flex flex-wrap items-center gap-8 justify-center">
              <div class="flex items-center gap-6 bg-on-surface/5 p-4 rounded-2xl">
                <div class="flex flex-col">
                  <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-[0.2em] mb-2">Fecha Inicial</span>
                  <input type="date" v-model="filterDateStart" class="bg-transparent border-none text-sm font-black text-on-surface outline-none cursor-pointer" />
                </div>
                <div class="w-px h-10 bg-on-surface/10"></div>
                <div class="flex flex-col">
                  <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-[0.2em] mb-2">Fecha Final</span>
                  <input type="date" v-model="filterDateEnd" class="bg-transparent border-none text-sm font-black text-on-surface outline-none cursor-pointer" />
                </div>
              </div>
              
              <div class="h-10 w-px bg-on-surface/10"></div>

              <div class="flex items-center gap-4">
                 <span class="text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Tipo de Acción</span>
                 <div class="flex gap-2">
                   <button v-for="opt in ['all', 'POST', 'PUT', 'DELETE', 'LOGIN']" :key="opt"
                     @click="filterAction = opt"
                     class="px-4 py-2 rounded-xl text-[9px] font-black uppercase transition-all"
                     :class="filterAction === opt ? 'bg-accent-neon text-black' : 'bg-on-surface/5 text-on-surface/40 hover:bg-on-surface/10'"
                   >
                     {{ opt === 'all' ? 'Todo' : opt }}
                   </button>
                 </div>
              </div>
            </div>
          </div>
        </transition>
      </teleport>
    </div>

    <!-- Main Content Table -->
    <div class="glass-card-premium rounded-[40px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando logs...</p>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full min-w-[900px] text-left border-separate border-spacing-0">
          <thead>
            <tr>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Fecha y Hora</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Actor</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Acción</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Dirección IP</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Descripción</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest text-right">Detalle</th>
            </tr>
          </thead>
          <tbody class="bg-transparent">
            <template v-for="(group, date) in groupedLogs" :key="date">
              <!-- Date Header Row -->
              <tr class="bg-accent-neon/[0.02]">
                <td colspan="6" class="px-6 py-4">
                  <div class="flex items-center gap-4">
                    <div class="flex items-center gap-2">
                      <span class="material-symbols-outlined text-accent-neon text-sm">calendar_today</span>
                      <span class="text-[10px] font-black text-accent-neon uppercase tracking-[0.4em]">{{ date }}</span>
                    </div>
                    <div class="h-px flex-1 bg-accent-neon/10"></div>
                    <span class="text-[9px] font-black text-on-surface/20 uppercase tracking-widest">{{ group.length }} eventos registrados</span>
                  </div>
                </td>
              </tr>
              
              <tr v-for="log in group" :key="log.id" class="group hover:bg-accent-neon/[0.02] transition-all duration-300">
                <td class="p-6 whitespace-nowrap">
                  <div class="flex flex-col gap-0.5">
                    <span class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">{{ formatDateShort(log.fecha_creacion) }}</span>
                    <span class="text-[10px] font-bold text-on-surface/30 font-mono">{{ formatTime(log.fecha_creacion) }}</span>
                  </div>
                </td>
                
                <td class="p-6">
                  <span v-if="log.usuario" class="text-xs font-black text-on-surface">
                    {{ log.usuario.nombres }} {{ log.usuario.apellidos }}
                  </span>
                  <span v-else class="text-xs font-black text-on-surface/40 uppercase tracking-widest">
                    Sistema
                  </span>
                </td>

                <td class="p-6">
                  <div class="flex flex-col gap-2">
                    <span :class="['px-3 py-1.5 text-[9px] font-black rounded-xl uppercase tracking-widest w-fit shadow-none', getActionClass(log.accion)]">
                      {{ log.accion }}
                    </span>
                    <div class="flex items-center gap-1.5 ml-1">
                      <span class="text-[10px] font-black text-on-surface/40 tracking-tighter uppercase">{{ log.entidad }}</span>
                      <div v-if="log.entidad_id" class="flex items-center gap-1 group/id">
                        <span class="px-2 py-0.5 rounded-lg bg-on-surface/5 text-on-surface/40 text-[9px] font-black">#{{ log.entidad_id }}</span>
                        <button @click.stop="copyToClipboard(log.entidad_id)" class="opacity-0 group-hover/id:opacity-100 transition-opacity text-accent-neon hover:scale-110" title="Copiar ID">
                          <span class="material-symbols-outlined text-[14px]">content_copy</span>
                        </button>
                      </div>
                    </div>
                  </div>
                </td>

                <td class="p-6">
                  <div class="flex items-center gap-3 group/ip">
                    <div class="w-8 h-8 rounded-lg bg-on-surface/5 flex items-center justify-center text-on-surface/30 group-hover/ip:bg-accent-neon/10 group-hover/ip:text-accent-neon transition-all">
                      <span class="material-symbols-outlined text-sm">lan</span>
                    </div>
                    <div class="flex flex-col">
                      <span class="text-xs font-mono text-on-surface/60 font-black group-hover/ip:text-on-surface transition-colors">{{ log.direccion_ip || '0.0.0.0' }}</span>
                      <div class="flex items-center gap-1.5">
                        <span class="px-1.5 py-0.5 rounded-md bg-on-surface/5 text-[8px] font-black uppercase tracking-tight text-on-surface/30 group-hover/ip:text-on-surface/50">{{ log.metodo_request }}</span>
                        <span class="w-1 h-1 rounded-full bg-on-surface/10"></span>
                        <span class="text-[8px] text-on-surface/10 font-bold uppercase group-hover/ip:text-accent-neon/40">Request OK</span>
                      </div>
                    </div>
                  </div>
                </td>

                <td class="p-6">
                  <p class="text-xs text-on-surface/50 leading-relaxed max-w-xs line-clamp-2 italic font-medium group-hover:text-on-surface/70 transition-colors">
                    "{{ log.descripcion || 'Sin descripción detallada' }}"
                  </p>
                </td>

                <td class="p-6 text-right">
                  <button 
                    @click="openDetails(log)" 
                    class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon hover:bg-accent-neon hover:text-black transition-all duration-300 shadow-sm hover:shadow-neon-sm ml-auto"
                  >
                    <span class="material-symbols-outlined text-lg">open_in_new</span>
                  </button>
                </td>
              </tr>
            </template>

            <tr v-if="filteredLogs.length === 0 && !loading">
              <td colspan="6" class="p-32 text-center">
                <div class="flex flex-col items-center gap-6 animate-float">
                  <div class="w-24 h-24 rounded-full bg-on-surface/5 flex items-center justify-center text-on-surface/10">
                    <span class="material-symbols-outlined text-6xl">search_off</span>
                  </div>
                  <div>
                    <h4 class="text-xl font-black text-on-surface font-lexend">Silencio en la red</h4>
                    <p class="text-sm font-bold text-on-surface/30 uppercase tracking-[0.2em] mt-2">No hay registros que coincidan con tus parámetros</p>
                  </div>
                  <button @click="resetFilters" class="btn-premium glass-card px-8">Restablecer Filtros</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Pagination -->
    <div class="flex items-center justify-between px-8 py-4 bg-on-surface/[0.03] rounded-[40px] !border-none">
      <div class="flex flex-col">
        <p class="text-[10px] font-black text-on-surface/30 uppercase tracking-widest">
          Mostrando {{ Math.min((currentPage - 1) * itemsPerPage + 1, filteredLogs.length) }} - {{ Math.min(currentPage * itemsPerPage, filteredLogs.length) }} 
          de {{ filteredLogs.length }} eventos
        </p>
      </div>
      
      <div class="flex items-center gap-4">
        <div class="flex items-center gap-2 mr-4">
           <span class="text-[10px] font-black text-on-surface/20 uppercase">Por página:</span>
           <select v-model="itemsPerPage" @change="currentPage = 1" class="bg-transparent text-[10px] font-black text-on-surface/40 border-none outline-none cursor-pointer">
             <option :value="10">10</option>
             <option :value="20">20</option>
             <option :value="50">50</option>
             <option :value="100">100</option>
           </select>
        </div>

        <div class="flex gap-2">
          <button 
            @click="currentPage--" 
            :disabled="currentPage === 1"
            class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-accent-neon hover:text-black disabled:opacity-20 transition-all shadow-sm"
          >
            <span class="material-symbols-outlined text-sm">chevron_left</span>
          </button>
          
          <div class="flex items-center px-4 bg-on-surface/5 rounded-xl">
            <span class="text-[10px] font-black text-on-surface tracking-widest">{{ currentPage }} <span class="text-on-surface/20">/</span> {{ totalPages || 1 }}</span>
          </div>

          <button 
            @click="currentPage++" 
            :disabled="currentPage >= totalPages"
            class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-accent-neon hover:text-black disabled:opacity-20 transition-all shadow-sm"
          >
            <span class="material-symbols-outlined text-sm">chevron_right</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Modal Flotante de Detalles (Optimizado sin líneas blancas, totalmente consistente) -->
    <teleport to="body">
      <transition name="fade">
        <div 
          v-if="selectedLog" 
          class="fixed inset-0 z-[300] flex items-center justify-center bg-black/80 backdrop-blur-md p-4 sm:p-6" 
          @click="selectedLog = null"
        >
          <div 
            class="glass-card-premium relative max-w-5xl w-full max-h-[88vh] bg-surface dark:bg-surface border border-white/10 p-5 sm:p-8 rounded-[40px] flex flex-col gap-6 shadow-2xl overflow-hidden text-on-surface" 
            @click.stop
          >
            
            <!-- Encabezado del Modal -->
            <div class="flex items-center justify-between border-b border-white/15 pb-4">
              <div class="flex items-center gap-4">
                <div :class="['w-12 h-12 rounded-2xl flex items-center justify-center shadow-xl shrink-0 text-white', getActionBgClass(selectedLog.accion)]">
                  <span class="material-symbols-outlined text-2xl">{{ getActionIcon(selectedLog.accion) }}</span>
                </div>
                <div>
                  <div class="flex items-center gap-3">
                    <h3 class="text-lg font-black tracking-tight leading-tight">
                      Auditoría de <span class="text-accent-neon">{{ selectedLog.accion }}</span>
                    </h3>
                    <span class="px-3 py-0.5 rounded-full bg-accent-neon/10 text-accent-neon text-[9px] font-black tracking-widest">REF: {{ selectedLog.id }}</span>
                  </div>
                  <p class="text-[10px] font-medium text-on-surface/50 uppercase tracking-widest mt-0.5">
                    {{ selectedLog.entidad }} // Identificador: #{{ selectedLog.entidad_id || 'Global' }}
                  </p>
                </div>
              </div>

              <button 
                type="button" 
                @click="selectedLog = null" 
                class="p-2 rounded-xl text-on-surface/40 hover:text-on-surface hover:bg-white/10 transition-colors"
              >
                <span class="material-symbols-outlined text-xl">close</span>
              </button>
            </div>

            <!-- Contenido Principal del Visor (Scrollable) -->
            <div class="flex-1 min-h-[320px] max-h-[62vh] overflow-y-auto space-y-6 pr-2 custom-scrollbar">
              
              <!-- Context Grid (Tarjetas de alto impacto visual) -->
              <div class="grid grid-cols-1 lg:grid-cols-3 gap-5">
                <div class="bg-white/[0.04] border border-white/10 p-5 rounded-2xl relative overflow-hidden group">
                  <div class="absolute top-0 right-0 p-3 opacity-10">
                    <span class="material-symbols-outlined text-3xl">person</span>
                  </div>
                  <span class="text-[9px] font-black text-on-surface/40 uppercase tracking-widest block mb-3">Responsable</span>
                  <div v-if="selectedLog.usuario" class="flex flex-col gap-1">
                    <span class="text-xs font-black">{{ selectedLog.usuario.nombres }} {{ selectedLog.usuario.apellidos }}</span>
                    <span class="text-[10px] text-accent-neon font-mono font-bold">{{ selectedLog.usuario.correo }}</span>
                    <span class="text-[8px] text-on-surface/30 uppercase mt-1">ID: {{ selectedLog.usuario_id }}</span>
                  </div>
                  <div v-else class="flex flex-col gap-1 opacity-50">
                    <span class="text-xs font-black italic">Agente de Sistema</span>
                    <span class="text-[9px] uppercase">Proceso Automático</span>
                  </div>
                </div>

                <div class="bg-white/[0.04] border border-white/10 p-5 rounded-2xl relative overflow-hidden group">
                  <div class="absolute top-0 right-0 p-3 opacity-10">
                    <span class="material-symbols-outlined text-3xl">terminal</span>
                  </div>
                  <span class="text-[9px] font-black text-on-surface/40 uppercase tracking-widest block mb-3">Origen de Petición</span>
                  <div class="flex flex-col gap-1">
                    <span class="text-xs font-black font-mono">{{ selectedLog.direccion_ip }}</span>
                    <span class="text-[9px] text-on-surface/50 font-mono break-all line-clamp-1">{{ selectedLog.user_agent }}</span>
                    <span class="text-[8px] text-accent-neon uppercase mt-1 font-bold">{{ selectedLog.metodo_request }} Endpoint OK</span>
                  </div>
                </div>

                <div class="bg-white/[0.04] border border-white/10 p-5 rounded-2xl relative overflow-hidden group">
                  <div class="absolute top-0 right-0 p-3 opacity-10">
                    <span class="material-symbols-outlined text-3xl">schedule</span>
                  </div>
                  <span class="text-[9px] font-black text-on-surface/40 uppercase tracking-widest block mb-3">Cronología</span>
                  <div class="flex flex-col gap-1">
                    <span class="text-xs font-black">{{ formatDateLong(selectedLog.fecha_creacion) }}</span>
                    <span class="text-sm font-black text-accent-neon font-mono">{{ formatTime(selectedLog.fecha_creacion) }}</span>
                    <span class="text-[8px] text-on-surface/30 uppercase mt-1">{{ getTimeAgo(selectedLog.fecha_creacion) }}</span>
                  </div>
                </div>
              </div>

              <!-- Narrativa de Actividad -->
              <div class="bg-white/[0.03] border border-white/10 p-6 rounded-2xl relative overflow-hidden">
                <div class="absolute left-0 top-0 bottom-0 w-1 bg-accent-neon"></div>
                <span class="text-[9px] font-black text-on-surface/40 uppercase tracking-widest block mb-2">Descripción del Evento</span>
                <p class="text-xs font-medium text-on-surface/90 italic leading-relaxed">
                  "{{ selectedLog.descripcion }}"
                </p>
                <div class="mt-4 flex items-center gap-4 text-[10px] font-mono text-on-surface/50 border-t border-white/10 pt-3">
                  <span>Método: <strong class="text-accent-neon">{{ selectedLog.metodo_request }}</strong></span>
                  <span>•</span>
                  <span>Ruta: <strong class="text-on-surface/80">{{ selectedLog.endpoint }}</strong></span>
                </div>
              </div>

              <!-- Análisis de Diferencias (Diff Viewer) -->
              <div v-if="diffAnalysis" class="space-y-4">
                <div class="flex items-center justify-between">
                  <div class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
                      <span class="material-symbols-outlined text-base">difference</span>
                    </div>
                    <h4 class="text-xs font-black uppercase tracking-widest">Cambios Detectados (Diff)</h4>
                  </div>
                  <span class="px-3 py-1 rounded-full bg-accent-neon text-black text-[9px] font-black uppercase">
                    {{ diffAnalysis.length }} Modificaciones
                  </span>
                </div>

                <div class="grid grid-cols-1 gap-4">
                  <div v-for="change in diffAnalysis" :key="change.key" class="bg-white/[0.03] border border-white/10 p-5 rounded-2xl space-y-3">
                    <div class="flex items-center justify-between">
                      <span class="text-xs font-black text-accent-neon uppercase font-mono tracking-wider">{{ change.key }}</span>
                      <div class="flex gap-2">
                        <button @click="copyToClipboard(change.old)" class="p-1.5 rounded-lg bg-white/5 hover:bg-white/10 text-on-surface/60 text-xs" title="Copiar anterior">
                          <span class="material-symbols-outlined text-sm">history</span>
                        </button>
                        <button @click="copyToClipboard(change.new)" class="p-1.5 rounded-lg bg-white/5 hover:bg-white/10 text-on-surface/60 text-xs" title="Copiar nuevo">
                          <span class="material-symbols-outlined text-sm">content_copy</span>
                        </button>
                      </div>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div class="p-4 rounded-xl bg-red-500/[0.06] border border-red-500/20">
                        <span class="text-[8px] font-black text-red-400 uppercase tracking-widest block mb-2">Valor Anterior</span>
                        <pre class="text-[11px] text-red-300 font-mono whitespace-pre-wrap break-all">{{ typeof change.old === 'object' ? JSON.stringify(change.old, null, 2) : (change.old || '(Vacío)') }}</pre>
                      </div>
                      <div class="p-4 rounded-xl bg-green-500/[0.06] border border-green-500/20">
                        <span class="text-[8px] font-black text-green-400 uppercase tracking-widest block mb-2">Valor Nuevo</span>
                        <pre class="text-[11px] text-green-300 font-mono whitespace-pre-wrap break-all font-bold">{{ typeof change.new === 'object' ? JSON.stringify(change.new, null, 2) : (change.new || '(Vacío)') }}</pre>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Estados JSON Completos (Anterior y Nuevo) -->
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="space-y-3">
                  <div class="flex items-center justify-between">
                    <span class="text-[10px] font-black text-red-400 uppercase tracking-widest flex items-center gap-1.5">
                      <span class="w-1.5 h-1.5 rounded-full bg-red-400"></span> Estado Anterior (JSON)
                    </span>
                    <button v-if="selectedLog.valores_anteriores" @click="copyToClipboard(selectedLog.valores_anteriores)" class="text-[9px] text-on-surface/50 hover:text-on-surface">Copiar</button>
                  </div>
                  <div class="bg-black/40 border border-white/10 p-5 rounded-2xl font-mono text-[10px] text-on-surface/70 overflow-x-auto max-h-[200px]">
                    <pre v-if="selectedLog.valores_anteriores">{{ safeStringify(selectedLog.valores_anteriores) }}</pre>
                    <span v-else class="text-on-surface/30 italic">Sin datos previos registrados</span>
                  </div>
                </div>

                <div class="space-y-3">
                  <div class="flex items-center justify-between">
                    <span class="text-[10px] font-black text-green-400 uppercase tracking-widest flex items-center gap-1.5">
                      <span class="w-1.5 h-1.5 rounded-full bg-green-400"></span> Estado Nuevo (JSON)
                    </span>
                    <button v-if="selectedLog.valores_nuevos" @click="copyToClipboard(selectedLog.valores_nuevos)" class="text-[9px] text-on-surface/50 hover:text-on-surface">Copiar</button>
                  </div>
                  <div class="bg-black/40 border border-white/10 p-5 rounded-2xl font-mono text-[10px] text-green-400 overflow-x-auto max-h-[200px]">
                    <pre v-if="selectedLog.valores_nuevos">{{ safeStringify(selectedLog.valores_nuevos) }}</pre>
                    <span v-else class="text-on-surface/30 italic">Sin mutación resultante registrada</span>
                  </div>
                </div>
              </div>

            </div>

            <!-- Pie de Página / Acciones del Modal -->
            <div class="flex items-center justify-between pt-4 border-t border-white/15 shrink-0">
              <span class="text-[9px] font-bold text-on-surface/40 uppercase tracking-widest">AuditoriaInterceptor v2.0</span>

              <button 
                type="button" 
                @click="selectedLog = null" 
                class="px-6 py-2.5 rounded-xl bg-accent-neon text-background text-xs font-black uppercase tracking-widest shadow-lg hover:shadow-accent-neon/20 hover:-translate-y-0.5 active:scale-95 transition-all"
              >
                Cerrar
              </button>
            </div>

          </div>
        </div>
      </transition>
    </teleport>

  </div>
</template>
<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'
import ExcelJS from 'exceljs';
import { saveAs } from 'file-saver';
import pdfMake from 'pdfmake/build/pdfmake';
import * as pdfFonts from 'pdfmake/build/vfs_fonts';

// Inicializar las fuentes del navegador para pdfMake
pdfMake.vfs = pdfFonts.pdfMake ? pdfFonts.pdfMake.vfs : pdfMake.vfs;

const exportStatus = ref({
  pdf: 'idle',
  image: 'idle', // Si solo usas PDF en este módulo, puedes dejarlo o incluirlo por consistencia
  excel: 'idle'
});

const logs = ref([])
const loading = ref(true)
const selectedLog = ref(null)
const notificationStore = useNotificationStore()
const modalStore = useModalStore()

// Filter states
const searchQuery = ref('')
const filterAction = ref('all')
const filterDateStart = ref('')
const filterDateEnd = ref('')
const showDatePicker = ref(false)
const filterBarRef = ref(null)
const datePickerStyle = ref({})

const computeDatePickerPosition = () => {
  if (!filterBarRef.value) return
  const rect = filterBarRef.value.getBoundingClientRect()
  datePickerStyle.value = {
    position: 'fixed',
    top: `${rect.bottom + 10}px`,
    left: `${rect.left}px`,
    width: `${rect.width}px`,
    zIndex: 9999
  }
}

const toggleDatePicker = () => {
  showDatePicker.value = !showDatePicker.value
  if (showDatePicker.value) {
    computeDatePickerPosition()
  }
}

// Pagination
const currentPage = ref(1)
const itemsPerPage = ref(20)

const hasDateFilter = computed(() => {
  return filterDateStart.value || filterDateEnd.value
})

const filteredLogs = computed(() => {
  if (!logs.value) return []
  
  return logs.value.filter(log => {
    // Search filter
    const query = searchQuery.value.toLowerCase()
    const matchesSearch = !query || 
      log.accion?.toLowerCase().includes(query) ||
      (log.usuario && (log.usuario.nombres + ' ' + log.usuario.apellidos).toLowerCase().includes(query)) ||
      log.entidad?.toLowerCase().includes(query) ||
      log.descripcion?.toLowerCase().includes(query) ||
      String(log.entidad_id).includes(query) ||
      log.direccion_ip?.includes(query) ||
      String(log.id).includes(query)

    // Action/Method filter
    const matchesAction = filterAction.value === 'all' || 
      (filterAction.value === 'POST' && log.metodo_request === 'POST') ||
      (filterAction.value === 'PUT' && ['PUT', 'PATCH'].includes(log.metodo_request)) ||
      (filterAction.value === 'DELETE' && log.metodo_request === 'DELETE') ||
      (filterAction.value === 'LOGIN' && (log.accion.includes('LOGIN') || log.endpoint.includes('login')))

    // Date filter
    let matchesDate = true
    if (filterDateStart.value && filterDateEnd.value) {
      const logDate = new Date(log.fecha_creacion).toISOString().split('T')[0]
      matchesDate = logDate >= filterDateStart.value && logDate <= filterDateEnd.value
    } else if (filterDateStart.value) {
      const logDate = new Date(log.fecha_creacion).toISOString().split('T')[0]
      matchesDate = logDate >= filterDateStart.value
    } else if (filterDateEnd.value) {
      const logDate = new Date(log.fecha_creacion).toISOString().split('T')[0]
      matchesDate = logDate <= filterDateEnd.value
    }

    return matchesSearch && matchesAction && matchesDate
  }).sort((a, b) => new Date(b.fecha_creacion) - new Date(a.fecha_creacion))
})

const hasFilters = computed(() => {
  return searchQuery.value || filterDateStart.value || filterDateEnd.value || filterAction.value !== 'all'
})

const totalPages = computed(() => Math.ceil(filteredLogs.value.length / itemsPerPage.value))

const paginatedLogs = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  const end = start + itemsPerPage.value
  return filteredLogs.value.slice(start, end)
})

const groupedLogs = computed(() => {
  const groups = {}
  paginatedLogs.value.forEach(log => {
    const date = formatDate(log.fecha_creacion)
    if (!groups[date]) groups[date] = []
    groups[date].push(log)
  })
  return groups
})

const fetchLogs = async () => {
  loading.value = true
  try {
    const res = await api.get('/auditoria')
    logs.value = res.data
  } catch (error) {
    console.error('Error fetching logs:', error)
    notificationStore.addNotification({
      title: 'Fallo de Sincronización',
      message: 'No se pudo recuperar el historial de auditoría desde el servidor.',
      type: 'error'
    })
  } finally {
    loading.value = false
  }
}

// Stats computations
// Stats computations
const totalLogs = computed(() => logs.value.length)
const stats = computed(() => {
  const creations = logs.value.filter(l => l.metodo_request === 'POST').length
  const updates = logs.value.filter(l => ['PUT', 'PATCH'].includes(l.metodo_request)).length
  const deletions = logs.value.filter(l => l.metodo_request === 'DELETE').length
  
  const today = new Date().toISOString().split('T')[0]
  const creationsToday = logs.value.filter(l => l.metodo_request === 'POST' && l.fecha_creacion.startsWith(today)).length
  
  const updatesPct = totalLogs.value > 0 ? Math.round((updates / totalLogs.value) * 100) : 0
  
  return { creations, updates, deletions, creationsToday, updatesPct }
})

// Helpers to safely parse/stringify snapshot values which may be JSON strings or objects
const parseIfJson = (val) => {
  if (val === null || val === undefined) return null
  if (typeof val === 'string') {
    try {
      return JSON.parse(val)
    } catch (e) {
      return val
    }
  }
  return val
}

const safeStringify = (val) => {
  const parsed = parseIfJson(val)
  try {
    return typeof parsed === 'string' ? parsed : JSON.stringify(parsed, null, 2)
  } catch (e) {
    return String(parsed)
  }
}

const DIFF_LIMIT = 10
const showAllChanges = ref(false)

const diffAnalysisRaw = computed(() => {
  if (!selectedLog.value) return null
  const oldVal = parseIfJson(selectedLog.value.valores_anteriores) || {}
  const newVal = parseIfJson(selectedLog.value.valores_nuevos) || {}
  const changes = []

  const allKeys = new Set([...(oldVal && typeof oldVal === 'object' ? Object.keys(oldVal) : []), ...(newVal && typeof newVal === 'object' ? Object.keys(newVal) : [])])
  allKeys.forEach(key => {
    const vOld = oldVal ? oldVal[key] : undefined
    const vNew = newVal ? newVal[key] : undefined
    try {
      if (JSON.stringify(vOld) !== JSON.stringify(vNew)) {
        changes.push({ key, old: vOld, new: vNew })
      }
    } catch (e) {
      if (String(vOld) !== String(vNew)) {
        changes.push({ key, old: vOld, new: vNew })
      }
    }
  })

  return changes.length > 0 ? changes : null
})

const diffAnalysis = computed(() => {
  if (!diffAnalysisRaw.value) return null
  if (showAllChanges.value) return diffAnalysisRaw.value
  return diffAnalysisRaw.value.slice(0, DIFF_LIMIT)
})

const moreChangesCount = computed(() => diffAnalysisRaw.value ? Math.max(0, diffAnalysisRaw.value.length - DIFF_LIMIT) : 0)

const topStats = computed(() => {
  const userCounts = {}
  const entityCounts = {}
  
  logs.value.forEach(log => {
    if (log.usuario) {
      const name = `${log.usuario.nombres} ${log.usuario.apellidos}`
      userCounts[name] = (userCounts[name] || 0) + 1
    }
    entityCounts[log.entidad] = (entityCounts[log.entidad] || 0) + 1
  })
  
  const topUser = Object.entries(userCounts).sort((a, b) => b[1] - a[1])[0] || ['Sistema', 0]
  const topEntity = Object.entries(entityCounts).sort((a, b) => b[1] - a[1])[0] || ['N/A', 0]
  
  return { topUser, topEntity }
})

const activityChart = computed(() => {
  const days = {}
  const now = new Date()
  for (let i = 9; i >= 0; i--) {
    const d = new Date()
    d.setDate(now.getDate() - i)
    days[d.toISOString().split('T')[0]] = 0
  }
  
  logs.value.forEach(log => {
    const date = log.fecha_creacion.split('T')[0]
    if (days[date] !== undefined) {
      days[date]++
    }
  })
  
  const max = Math.max(...Object.values(days), 1)
  return Object.entries(days).map(([date, count]) => ({
    date,
    count,
    height: (count / max) * 100
  }))
})



const resetFilters = () => {
  searchQuery.value = ''
  filterDateStart.value = ''
  filterDateEnd.value = ''
  filterAction.value = 'all'
  showDatePicker.value = false
}

const setQuickDate = (period) => {
  const now = new Date()
  const today = now.toISOString().split('T')[0]
  
  if (period === 'today') {
    filterDateStart.value = today
    filterDateEnd.value = today
  } else if (period === 'week') {
    const lastWeekDate = new Date()
    lastWeekDate.setDate(now.getDate() - 7)
    filterDateStart.value = lastWeekDate.toISOString().split('T')[0]
    filterDateEnd.value = today
  } else if (period === 'month') {
    const lastMonthDate = new Date()
    lastMonthDate.setMonth(now.getMonth() - 1)
    filterDateStart.value = lastMonthDate.toISOString().split('T')[0]
    filterDateEnd.value = today
  }
}

const isQuickDateActive = (period) => {
  const now = new Date()
  const today = now.toISOString().split('T')[0]
  if (period === 'today') {
    return filterDateStart.value === today && filterDateEnd.value === today
  }
  if (period === 'week') {
    const lastWeekDate = new Date()
    lastWeekDate.setDate(now.getDate() - 7)
    const lastWeek = lastWeekDate.toISOString().split('T')[0]
    return filterDateStart.value === lastWeek && filterDateEnd.value === today
  }
  if (period === 'month') {
    const lastMonthDate = new Date()
    lastMonthDate.setMonth(now.getMonth() - 1)
    const lastMonth = lastMonthDate.toISOString().split('T')[0]
    return filterDateStart.value === lastMonth && filterDateEnd.value === today
  }
  return false
}

const formatDate = (dateStr) => {
  return new Date(dateStr).toLocaleDateString('es-ES', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  })
}

const formatDateShort = (dateStr) => {
  return new Date(dateStr).toLocaleDateString('es-ES', {
    day: '2-digit',
    month: '2-digit'
    
  })
}

const formatDateLong = (dateStr) => {
  return new Date(dateStr).toLocaleDateString('es-ES', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  })
}

const formatTime = (dateStr) => {
  return new Date(dateStr).toLocaleTimeString('es-ES', {
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  })
}

const getTimeAgo = (dateStr) => {
  const seconds = Math.floor((new Date() - new Date(dateStr)) / 1000)
  if (seconds < 60) return 'Hace un momento'
  const minutes = Math.floor(seconds / 60)
  if (minutes < 60) return `Hace ${minutes} min`
  const hours = Math.floor(minutes / 60)
  if (hours < 24) return `Hace ${hours} h`
  return 'Hace más de un día'
}

const openDetails = (log) => {
  selectedLog.value = log
}

const copyToClipboard = (data) => {
  if (!data) return
  navigator.clipboard.writeText(JSON.stringify(data, null, 2))
  notificationStore.addNotification({
    title: 'Copiado',
    message: 'JSON copiado al portapapeles',
    type: 'success'
  })
}

//EXPORTA EXCEL
const exportToExcel = async () => {
  if (filteredLogs.value.length === 0) return;
  if (exportStatus.value.excel !== 'idle') return;

  exportStatus.value.excel = 'loading';

  try {
    // 1. Crear el libro y la hoja
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Logs de Auditoría');

  // 2. Definir las columnas con sus respectivas llaves (keys)
  // Dejamos un ancho inicial estimado, luego el código lo autoajustará
  worksheet.columns = [
    { header: 'Fecha', key: 'fecha', width: 15 },
    { header: 'Hora', key: 'hora', width: 12 },
    { header: 'Usuario', key: 'usuario', width: 25 },
    { header: 'Correo', key: 'correo', width: 25 },
    { header: 'Acción', key: 'accion', width: 15 },
    { header: 'Entidad', key: 'entidad', width: 15 },
    { header: 'ID Entidad', key: 'id_entidad', width: 12 },
    { header: 'IP', key: 'ip', width: 16 },
    { header: 'Método', key: 'metodo', width: 12 },
    { header: 'Endpoint', key: 'endpoint', width: 30 },
    { header: 'Descripción', key: 'descripcion', width: 40 },
  ];

  // 3. Estilizar la fila de Encabezados (Fila 1)
  const headerRow = worksheet.getRow(1);
  headerRow.height = 26; // Altura para que no se vea apretado

  headerRow.eachCell((cell) => {
    // Fondo Azul Oscuro Corporativo
    cell.fill = {
      type: 'pattern',
      pattern: 'solid',
      fgColor: { argb: 'FF2C3E50' }, 
    };
    // Texto Blanco, Negrita y Fuente Limpia
    cell.font = {
      name: 'Segoe UI',
      size: 11,
      bold: true,
      color: { argb: 'FFFFFFFF' },
    };
    // Alineación Centrada
    cell.alignment = {
      vertical: 'middle',
      horizontal: 'center',
    };
    // Bordes laterales blancos para separar sutilmente las columnas
    cell.border = {
      left: { style: 'thin', color: { argb: 'FFFFFFFF' } },
      right: { style: 'thin', color: { argb: 'FFFFFFFF' } },
    };
  });

  // 4. Mapear e inyectar tus filas de datos tal como lo tenías
  filteredLogs.value.forEach(log => {
    const row = worksheet.addRow({
      fecha: formatDate(log.fecha_creacion),
      hora: formatTime(log.fecha_creacion),
      usuario: log.usuario ? `${log.usuario.nombres} ${log.usuario.apellidos}` : 'Sistema',
      correo: log.usuario ? log.usuario.correo : 'N/A',
      accion: log.accion,
      entidad: log.entidad,
      id_entidad: log.entidad_id || '',
      ip: log.direccion_ip || '',
      metodo: log.metodo_request || '',
      endpoint: log.endpoint || '',
      descripcion: log.descripcion || ''
    });

    row.height = 20; // Altura cómoda para leer los registros

    // Estilo sutil para las celdas de datos
    row.eachCell((cell, colNumber) => {
      cell.font = { name: 'Segoe UI', size: 10 };
      cell.alignment = { vertical: 'middle', horizontal: 'left' };

      // Centrar campos específicos como Fecha, Hora, ID, IP y Método
      if ([1, 2, 7, 8, 9].includes(colNumber)) {
        cell.alignment = { vertical: 'middle', horizontal: 'center' };
      }

      // Bordes inferiores grises muy suaves para separar registros
      cell.border = {
        bottom: { style: 'thin', color: { argb: 'FFE0E0E0' } },
      };
    });
  });

  // 5. AUTOAJUSTE INTELIGENTE DE COLUMNAS
  // Esto analiza el texto más largo de cada columna y la agranda para que NADA se corte
  worksheet.columns.forEach((column) => {
    let maxLen = 0;
    column.eachCell({ includeEmpty: true }, (cell) => {
      const valueStr = cell.value ? cell.value.toString() : '';
      if (valueStr.length > maxLen) {
        maxLen = valueStr.length;
      }
    });
    // Le añade un pequeño margen de 4 caracteres para que no quede exacto
    column.width = maxLen < 12 ? 12 : maxLen + 4;
  });

  // 6. Descargar el archivo XLSX real
    const buffer = await workbook.xlsx.writeBuffer();
    const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
    saveAs(blob, `auditoria_export_${new Date().getTime()}.xlsx`);

    exportStatus.value.excel = 'success';
    setTimeout(() => {
      exportStatus.value.excel = 'idle';
    }, 800);
  } catch (error) {
    console.error('Error al exportar auditoría a Excel:', error);
    exportStatus.value.excel = 'idle';
    notificationStore.addNotification({
      title: 'Error al exportar Excel',
      message: 'No se pudo generar el archivo Excel de auditoría.',
      type: 'error'
    });
  }
};


// Función auxiliar para cargar logos locales y convertirlos a PNG Base64 real
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

// Helper seguro para convertir los SVG en imágenes PNG Base64 incrustables en pdfmake
const svgToPngBase64 = (svgString, width = 48, height = 48) => {
  return new Promise((resolve) => {
    const encoded = encodeURIComponent(svgString);
    const img = new Image();
    img.crossOrigin = 'Anonymous';
    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = width;
      canvas.height = height;
      const ctx = canvas.getContext('2d');
      ctx.clearRect(0, 0, width, height);
      ctx.drawImage(img, 0, 0, width, height);
      resolve(canvas.toDataURL('image/png'));
    };
    img.onerror = () => resolve(null);
    img.src = `data:image/svg+xml;charset=utf-8,${encoded}`;
  });
};

const exportToPDF = async () => {
  if (filteredLogs.value.length === 0) return;
  if (exportStatus.value.pdf !== 'idle') return;

  exportStatus.value.pdf = 'loading';
  const pageWidth = 842.89; // Ancho A4 Landscape en puntos
  const usableWidth = pageWidth - 60; // Márgenes de 30 izquierdo y derecho

  try {
    // Simular un sutil tiempo de procesamiento para el spinner de la interfaz
    await new Promise(r => setTimeout(r, 600));

    // 1. Cargar el logotipo principal de forma segura
    let logoDataUrl = null;
    try {
      const logoPath = `${import.meta.env.BASE_URL}logo-dark.webp`.replace(/\/+/g, '/');
      logoDataUrl = await loadLogoToPngBase64(logoPath);
    } catch (e) {
      console.warn("No se pudo procesar el logotipo principal", e);
    }

    // 2. Cargar íconos corporativos y de redes sociales en paralelo para el pie de página
    const [iconLoc, iconPhone, iconWeb, iconRecycle, iconEmail, iconFb, iconTikTok, iconIn, iconYT, iconWsp] = await Promise.all([
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#7F8C8D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="7 10 12 5 17 10"/><line x1="12" y1="5" x2="12" y2="22"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14.5v-5h2v5h-2zm0-7v-2h2v2h-2z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64 2.93 2.93 0 0 1 .88.13V9.4a6.84 6.84 0 0 0-1-.05A6.33 6.33 0 0 0 5 20.1a6.34 6.34 0 0 0 10.86-4.43v-7a8.16 8.16 0 0 0 4.77 1.52v-3.4a4.85 4.85 0 0 1-1-.1z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M22.54 6.42a2.78 2.78 0 0 0-1.95-1.96C18.88 4 12 4 12 4s-6.88 0-8.59.46a2.78 2.78 0 0 0-1.95 1.96A29 29 0 0 0 1 12a29 29 0 0 0 .46 5.58 2.78 2.78 0 0 0 1.95 1.96C5.12 20 12 20 12 20s6.88 0 8.59-.46a2.78 2.78 0 0 0 1.95-1.96A29 29 0 0 0 23 12a29 29 0 0 0-.46-5.58z"/><polygon points="9.75 15.02 15.5 12 9.75 8.98 9.75 15.02" fill="#fff"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946.003-6.556 5.338-11.891 11.893-11.891 3.181.001 6.167 1.24 8.413 3.488 2.245 2.248 3.481 5.236 3.48 8.414-.003 6.557-5.338 11.892-11.893 11.892-1.99-.001-3.951-.5-5.688-1.448l-6.305 1.654zm6.597-3.807c1.676.995 3.276 1.591 5.392 1.592 5.448 0 9.886-4.434 9.889-9.885.002-5.462-4.415-9.89-9.881-9.892-5.452 0-9.887 4.434-9.889 9.884-.001 2.225.651 3.891 1.746 5.634l-.999 3.648 3.742-.981z"/></svg>')
    ]);

    // 3. Mapear tus datos
    const tableBody = [
      [
        { text: 'Fecha', style: 'tableHeader' },
        { text: 'Hora', style: 'tableHeader' },
        { text: 'Usuario', style: 'tableHeader' },
        { text: 'Correo', style: 'tableHeader' },
        { text: 'Acción', style: 'tableHeader' },
        { text: 'Entidad', style: 'tableHeader' },
        { text: 'ID', style: 'tableHeader' },
        { text: 'IP', style: 'tableHeader' },
        { text: 'Método', style: 'tableHeader' },
        { text: 'Endpoint', style: 'tableHeader' },
        { text: 'Descripción', style: 'tableHeader' }
      ]
    ];

    filteredLogs.value.forEach(log => {
      tableBody.push([
        { text: formatDate(log.fecha_creacion), style: 'tableCellCenter' },
        { text: formatTime(log.fecha_creacion), style: 'tableCellCenter' },
        { text: log.usuario ? `${log.usuario.nombres} ${log.usuario.apellidos}` : 'Sistema', style: 'tableCell' },
        { text: log.usuario ? log.usuario.correo : 'N/A', style: 'tableCell' },
        { text: log.accion, style: 'tableCell' },
        { text: log.entidad, style: 'tableCell' },
        { text: log.entidad_id || '', style: 'tableCellCenter' },
        { text: log.direccion_ip || '', style: 'tableCellCenter' },
        { text: log.metodo_request || '', style: 'tableCellCenter' },
        { text: log.endpoint || '', style: 'tableCellCode' },
        { text: log.descripcion || '', style: 'tableCell' }
      ]);
    });

    // 4. Configuración del Membrete Superior
    const contactInfo = [
      { text: 'Oficina Central y Centro Demostrativo:', bold: true, fontSize: 8, color: '#2C3E50' },
      { text: 'Calle Condorini, N° 118, zona Anari, Marquirivi\nGAMEP Achocalla, La Paz, Bolivia', fontSize: 8, color: '#2C3E50', margin: [0, 1, 0, 4] },
      { 
        columns: [
          ...(iconPhone ? [{ image: iconPhone, width: 10, height: 10, margin: [0, 1, 3, 0] }] : []),
          { text: '+591 732 36591  |  boris.ardaya@enervida.info', fontSize: 8, color: '#2C3E50' }
        ],
        columnGap: 4
      },
      { 
        columns: [
          ...(iconWeb ? [{ image: iconWeb, width: 10, height: 10, margin: [0, 1, 3, 0] }] : []),
          { text: 'www.enervida.info', fontSize: 8, color: '#2C3E50' }
        ],
        columnGap: 4,
        margin: [0, 2, 0, 0]
      }
    ];

    const headerConfig = {
      columns: [
        {
          columns: [
            ...(iconLoc ? [{ image: iconLoc, width: 11, height: 11, margin: [0, 1, 4, 0] }] : []),
            { stack: contactInfo }
          ],
          width: '65%',
          alignment: 'left'
        },
        ...(logoDataUrl ? [{ image: logoDataUrl, width: 150, alignment: 'right', margin: [0, 5, 0, 0] }] : [])
      ],
      margin: [30, 25, 30, 0]
    };

    const dividerLine = {
      canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
      margin: [30, 8, 30, 15]
    };

    // 5. Configuración del Pie de Página Institucional
    const socialIconsRow = [
      ...(iconEmail ? [{ image: iconEmail, width: 15, height: 15, link: 'mailto:boris.ardaya@enervida.info' }] : []),
      { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
      ...(iconWeb ? [{ image: iconWeb, width: 15, height: 15, link: 'https://www.enervida.info' }] : []),
      { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
      ...(iconFb ? [{ image: iconFb, width: 15, height: 15, link: 'https://facebook.com/enervida' }] : []),
      { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
      ...(iconTikTok ? [{ image: iconTikTok, width: 15, height: 15, link: 'https://tiktok.com/@enervida' }] : []),
      { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
      ...(iconIn ? [{ image: iconIn, width: 15, height: 15, link: 'https://linkedin.com/company/enervida' }] : []),
      { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
      ...(iconYT ? [{ image: iconYT, width: 15, height: 15, link: 'https://youtube.com/@enervida' }] : []),
      { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
      ...(iconWsp ? [{ image: iconWsp, width: 15, height: 15, link: 'https://wa.me/59173236591' }] : [])
    ];

    const footerConfig = (currentPage, pageCount) => {
      return {
        stack: [
          {
            canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
            margin: [30, 0, 30, 6]
          },
          {
            columns: [
              {
                columns: [
                  ...(iconRecycle ? [{ image: iconRecycle, width: 12, height: 12, margin: [0, 0, 4, 0] }] : []),
                  { text: 'Utilizamos papel de reciclaje para contribuir a la ODS 13 – Acción por el clima.', fontSize: 8, color: '#2C3E50' }
                ],
                width: '*',
                alignment: 'left'
              },
              {
                text: `Página | ${currentPage}`,
                alignment: 'right',
                fontSize: 8.5,
                bold: true,
                color: '#2C3E50',
                width: 'auto'
              }
            ],
            margin: [30, 0, 30, 4]
          },
          {
            columns: socialIconsRow,
            columnGap: 6,
            alignment: 'center',
            margin: [30, 0, 30, 12]
          }
        ]
      };
    };

    // 6. Estructura General del Documento
    const docDefinition = {
      pageSize: 'A4',
      pageOrientation: 'landscape',
      pageMargins: [30, 105, 30, 80],
      header: headerConfig,
      content: [
        dividerLine,
        { text: 'REPORTE DE LOGS DE AUDITORÍA', style: 'reportTitle', alignment: 'center' },
        { text: `Generado el: ${new Date().toLocaleString()}`, style: 'reportSubtitle', alignment: 'center', margin: [0, 2, 0, 15] },
        {
          style: 'tableExample',
          table: {
            headerRows: 1,
            widths: [50, 40, 65, 75, 45, 50, 25, 60, 40, 90, '*'],
            body: tableBody
          },
          layout: {
            hLineColor: (i) => (i === 0 || i === 1) ? '#2C3E50' : '#E0E0E0',
            vLineColor: () => '#E0E0E0',
            hLineWidth: (i) => (i === 0 || i === 1) ? 1.5 : 0.5,
            vLineWidth: () => 0.5,
          }
        }
      ],
      styles: {
        reportTitle: { fontSize: 15, bold: true, color: '#2C3E50' },
        reportSubtitle: { fontSize: 8.5, italics: true, color: '#95A5A6' },
        tableHeader: { bold: true, fontSize: 9, color: 'white', fillColor: '#2C3E50', alignment: 'center', margin: [0, 4, 0, 4] },
        tableCell: { fontSize: 8, color: '#333333', margin: [0, 3, 0, 3] },
        tableCellCenter: { fontSize: 8, color: '#333333', alignment: 'center', margin: [0, 3, 0, 3] },
        tableCellCode: { fontSize: 7.5, color: '#2980B9', margin: [0, 3, 0, 3] }
      },
      footer: footerConfig
    };

    // Cambiar estado visual a éxito e iniciar la descarga
    exportStatus.value.pdf = 'success';
    setTimeout(async () => {
      pdfMake.createPdf(docDefinition).download(`auditoria_report_${new Date().getTime()}.pdf`);
      setTimeout(() => {
        exportStatus.value.pdf = 'idle';
      }, 500);
    }, 1200);

  } catch (error) {
    console.error("Error al generar el PDF de auditoría:", error);
    exportStatus.value.pdf = 'idle';
  }
};

const confirmClearAll = () => {
  modalStore.openModal({
    title: '¿Purgar Bitácora Completa?',
    message: 'Esta acción eliminará permanentemente todos los registros de auditoría almacenados. No se recomienda a menos que el volumen de datos esté afectando el rendimiento.',
    confirmText: 'Sí, Purgar Todo',
    cancelText: 'Cancelar',
    type: 'danger',
    onConfirm: async () => {
      try {
        loading.value = true
        await api.delete('/auditoria/all/clear')
        notificationStore.addNotification({
          title: 'Purgado Exitoso',
          message: 'Se ha limpiado la base de datos de auditoría.',
          type: 'success'
        })
        logs.value = []
      } catch (error) {
        console.error('Error clearing logs:', error)
        notificationStore.addNotification({
          title: 'Error Crítico',
          message: 'Fallo al intentar limpiar la bitácora.',
          type: 'error'
        })
      } finally {
        loading.value = false
      }
    }
  })
}

// UI Helpers
const getActionClass = (accion) => {
  const a = accion.toLowerCase()
  if (a.includes('post') || a.includes('crear') || a.includes('create')) return 'bg-green-500/10 text-green-500'
  if (a.includes('delete') || a.includes('eliminar') || a.includes('remove')) return 'bg-red-500/10 text-red-500'
  if (a.includes('put') || a.includes('patch') || a.includes('actualizar') || a.includes('update')) return 'bg-blue-500/10 text-blue-500 border-blue-500/20'
  if (a.includes('login')) return 'bg-accent-neon/10 text-accent-neon'
  return 'bg-on-surface/5 text-on-surface/40'
}

const getActionBgClass = (accion) => {
  const a = accion.toLowerCase()
  if (a.includes('post') || a.includes('crear') || a.includes('create')) return 'bg-green-500'
  if (a.includes('delete') || a.includes('eliminar') || a.includes('remove')) return 'bg-red-500'
  if (a.includes('put') || a.includes('patch') || a.includes('actualizar') || a.includes('update')) return 'bg-blue-500'
  return 'bg-accent-neon'
}

const getActionIcon = (accion) => {
  const a = accion.toLowerCase()
  if (a.includes('crear') || a.includes('create')) return 'add_circle'
  if (a.includes('eliminar') || a.includes('delete')) return 'delete_forever'
  if (a.includes('actualizar') || a.includes('update')) return 'published_with_changes'
  if (a.includes('login')) return 'login'
  return 'info'
}

onMounted(() => {
  fetchLogs()
  const onResize = () => { if (showDatePicker.value) computeDatePickerPosition() }
  window.addEventListener('resize', onResize)
  onBeforeUnmount(() => window.removeEventListener('resize', onResize))
})
</script>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.8s cubic-bezier(0.16, 1, 0.3, 1);
}

.animate-scale-in {
  animation: scaleIn 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes scaleIn {
  from { opacity: 0; transform: scale(0.9) translateY(40px); }
  to { opacity: 1; transform: scale(1) translateY(0); }
}

.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: rgba(var(--on-surface-rgb), 0.01);
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(6, 182, 212, 0.2);
  border-radius: 10px;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba(6, 182, 212, 0.4);
}

.btn-icon-premium {
  width: 2.5rem;
  height: 2.5rem;
  border-radius: 0.75rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(6, 182, 212, 0.05);
  color: rgba(6, 182, 212, 0.8);
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  border: 1px solid rgba(6, 182, 212, 0.2);
}

.btn-icon-premium:hover {
  background-color: #06b6d4;
  color: #000;
  box-shadow: 0 0 20px rgba(6, 182, 212, 0.4);
  transform: translateY(-2px);
  border-color: transparent;
}
</style>