<template>
  <div class="min-h-screen admin-surface text-on-surface font-inter">
    <transition name="fade">
      <div
        v-if="isMobileMenuOpen"
        class="fixed inset-0 z-[104] bg-background/80 backdrop-blur-sm lg:hidden"
        @click="isMobileMenuOpen = false"
      ></div>
    </transition>

    <nav class="fixed left-0 right-0 top-0 z-[100] !border-none bg-surface-glass/90 backdrop-blur-2xl">
      <div class="flex h-20 items-center justify-between gap-3 px-4 md:px-8 xl:px-12">
        <div class="flex min-w-0 items-center gap-3 md:gap-10">
          <button
            type="button"
            class="admin-soft-hover grid h-11 w-11 place-items-center rounded-2xl text-on-surface lg:hidden"
            @click="isMobileMenuOpen = !isMobileMenuOpen"
            aria-label="Abrir menu del campus"
          >
            <span class="material-symbols-outlined">{{ isMobileMenuOpen ? 'close' : 'menu' }}</span>
          </button>

          <router-link to="/student/dashboard" class="flex min-w-0 items-center gap-3">
            <AppLogo :img-style="{ height: 'clamp(2rem, 4vw, 3rem)' }" img-class="w-auto object-contain" />
          </router-link>

          <div class="hidden items-center gap-1 lg:flex">
            <router-link
              v-for="link in navLinks"
              :key="link.id"
              :to="link.to"
              custom
              v-slot="{ navigate, href, isActive }"
            >
              <a
                :href="href"
                @click="navigate"
                :class="[
                  'rounded-xl px-4 xl:px-5 py-2 text-[10px] font-black uppercase tracking-[0.18em] transition-all',
                  isActive ? 'bg-accent-neon text-primary shadow-neon-sm' : 'text-on-surface/45 hover:bg-on-surface/5 hover:text-on-surface'
                ]"
              >
                {{ link.text }}
              </a>
            </router-link>
          </div>
        </div>

        <div class="flex shrink-0 items-center gap-2 sm:gap-4">
          <div class="hidden flex-col items-end xl:flex">
            <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/35">Estudiante</span>
            <span class="max-w-[160px] truncate text-xs font-bold">{{ authStore.user?.nombres || 'Mi cuenta' }}</span>
          </div>
          <div class="hidden rounded-2xl !border-none !bg-on-surface/[0.04] px-3 py-2 lg:flex lg:flex-col">
            <span class="text-[9px] font-black uppercase tracking-[0.2em] text-on-surface/30">Vista actual</span>
            <span class="text-[11px] font-black uppercase tracking-widest text-accent-neon">{{ currentNavLabel }}</span>
          </div>
          <div class="flex items-center gap-2 mr-2">  
            <ThemeToggle />
          </div>
          <div class="h-8 w-px bg-on-surface/5 mx-1 hidden sm:block"></div>
          <NotificationDropdown 
            :notifications="notifications" 
            @update="fetchStudentData" 
          />
          <router-link to="/student/support" class="flex h-10 w-10 items-center justify-center rounded-xl bg-on-surface/5 text-on-surface/45 transition hover:text-accent-neon" title="Soporte y ayuda">
            <span class="material-symbols-outlined text-xl">help</span>
          </router-link>
          <router-link to="/student/profile" class="flex h-11 w-11 items-center justify-center overflow-hidden rounded-2xl !border-none !bg-on-surface/[0.04] text-sm font-black text-accent-neon" aria-label="Perfil">
            <img
              v-if="profileImageUrl && !profileImageFailed"
              :src="profileImageUrl"
              :alt="`Perfil de ${authStore.user?.nombres || 'estudiante'}`"
              referrerpolicy="no-referrer"
              class="h-full w-full object-cover"
              @error="profileImageFailed = true"
            />
            
            <div 
              v-else 
              class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-600/20 to-indigo-600/30 text-blue-400 font-black text-sm uppercase tracking-wider border border-blue-500/10"
            >
              {{ userInitials }}
            </div>
          </router-link>
          <button @click="handleLogout" class="flex h-10 w-10 items-center justify-center rounded-xl bg-on-surface/5 text-on-surface/45 transition hover:text-accent-neon">
            <span class="material-symbols-outlined text-xl">logout</span>
          </button>
        </div>
      </div>
    </nav>

    <!-- Menú móvil Bottom Sheet (Estilo App Nativa) -->
    <transition
      enter-active-class="transition-all duration-500 ease-[cubic-bezier(0.34,1.56,0.64,1)]"
      enter-from-class="translate-y-full opacity-0"
      enter-to-class="translate-y-0 opacity-100"
      leave-active-class="transition-all duration-300 ease-[cubic-bezier(0.4,0,1,1)]"
      leave-from-class="translate-y-0 opacity-100"
      leave-to-class="translate-y-full opacity-0"
    >
      <div
        v-if="isMobileMenuOpen"
        class="fixed inset-x-0 bottom-0 z-[105] flex flex-col rounded-t-[2.5rem] bg-surface-glass/95 backdrop-blur-3xl border-t border-white/5 shadow-[0_-20px_50px_rgba(0,0,0,0.5)] lg:hidden max-h-[85vh]"
      >
        <!-- Drag Handle & Header -->
        <div class="flex flex-col items-center pt-4 pb-2 shrink-0">
          <div class="h-1.5 w-12 rounded-full bg-white/20 mb-4"></div>
          <div class="flex w-full items-center justify-between px-8">
            <h3 class="text-xs font-black uppercase tracking-[0.2em] text-on-surface/50">Navegación</h3>
            <button
              type="button"
              class="grid h-8 w-8 place-items-center rounded-full bg-white/5 text-on-surface hover:bg-white/10 transition-colors"
              @click="isMobileMenuOpen = false"
            >
              <span class="material-symbols-outlined text-sm">close</span>
            </button>
          </div>
        </div>

        <div class="flex-1 overflow-y-auto px-6 py-6">
          <div class="grid grid-cols-2 gap-3">
            <router-link
              v-for="(link, index) in navLinks"
              :key="link.id"
              :to="link.to"
              custom
              v-slot="{ navigate, href }"
            >
              <a
                :href="href"
                @click="(e) => { navigate(e); isMobileMenuOpen = false; }"
                :style="{ animationDelay: `${index * 60 + 100}ms` }"
                :class="[
                  'animate-pop-in flex flex-col items-center justify-center gap-3 rounded-3xl p-5 transition-colors duration-300',
                  isStudentRoute(link.to) ? 'bg-accent-neon/10 border border-accent-neon/20 shadow-neon-sm' : 'bg-white/5 border border-white/5 hover:bg-white/10'
                ]"
              >
                <span 
                  class="material-symbols-outlined text-3xl transition-transform group-hover:scale-110 duration-300"
                  :class="isStudentRoute(link.to) ? 'text-accent-neon' : 'text-on-surface/50'"
                >
                  {{ getIconForRoute(link.id) }}
                </span>
                <span 
                  class="text-[10px] font-black uppercase tracking-wider text-center"
                  :class="isStudentRoute(link.to) ? 'text-accent-neon' : 'text-on-surface/80'"
                >
                  {{ link.text }}
                </span>
              </a>
            </router-link>
          </div>
        </div>

        <!-- Perfil inferior -->
        <div class="shrink-0 p-6 border-t border-white/5 bg-black/20">
          <div class="flex items-center gap-4">
            <img
              v-if="profileImageUrl && !profileImageFailed"
              :src="profileImageUrl"
              class="h-12 w-12 rounded-full object-cover ring-2 ring-white/10"
              @error="profileImageFailed = true"
            />
            <div v-else class="flex h-12 w-12 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon font-black shadow-inner ring-2 ring-accent-neon/20">
              {{ userInitials }}
            </div>
            
            <div class="flex-1 min-w-0">
              <span class="block text-sm font-black truncate">{{ authStore.user?.nombres || 'Estudiante' }}</span>
              <router-link to="/student/profile" @click="isMobileMenuOpen = false" class="text-[10px] font-bold text-accent-neon uppercase tracking-widest mt-0.5 inline-block">
                Ver mi perfil &rarr;
              </router-link>
            </div>

            <button @click="handleLogout" class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-accent-solar/10 text-accent-solar hover:bg-accent-solar/20 transition-colors">
              <span class="material-symbols-outlined">logout</span>
            </button>
          </div>
        </div>
      </div>
    </transition>

    <main class="mx-auto max-w-[1600px] px-4 pb-12 pt-28 md:px-8 xl:px-12">
      <router-view v-slot="{ Component }">
        <transition name="fade-slide" mode="out-in">
          <component 
            :is="Component"
            :inscripciones="inscripciones"
            :available-courses="availableCourses"
            :ultimo-curso="ultimoCurso"
            :live-classes="liveClasses"
            :notifications="notifications"
            :loading="loading"
            @enroll="enrollInCourse"
          />
        </transition>
      </router-view>
    </main>

    <transition name="fade-slide">
      <div v-if="showCompleteProfile" class="fixed inset-0 z-[200] flex items-center justify-center p-3 sm:p-5 overflow-y-auto">
        <!-- Backdrop estático con blur -->
        <div class="fixed inset-0 bg-black/60 dark:bg-background/90 backdrop-blur-md transition-opacity" @click="cancelEnroll"></div>

        <!-- Contenedor Principal del Modal -->
        <div class="glass-card-premium relative w-full max-w-4xl max-h-[92vh] flex flex-col rounded-2xl sm:rounded-3xl bg-white dark:bg-surface border border-gray-200 dark:border-white/10 p-4 sm:p-6 shadow-2xl z-10 transition-all">
          
          <!-- Encabezado Compacto (Inline) -->
          <div class="flex items-center justify-between pb-3 mb-3 border-b border-gray-200 dark:border-white/10 shrink-0">
            <div class="flex items-center gap-2.5">
              <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-accent-neon/10 text-accent-neon shrink-0">
                <span class="material-symbols-outlined text-xl">verified_user</span>
              </div>
              <div>
                <h2 class="font-lexend text-base sm:text-lg font-black tracking-tight text-gray-900 dark:text-white leading-tight">
                  Verificación de <span class="text-gradient-neon">identidad</span>
                </h2>
                <p class="text-[10px] font-medium text-gray-500 dark:text-white/60">
                  Confirma tus datos para la emisión de certificados oficiales.
                </p>
              </div>
            </div>

            <!-- Botón de Cierre Rápido -->
            <button type="button" @click="cancelEnroll" class="p-1 rounded-lg text-gray-400 dark:text-white/40 hover:text-gray-700 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5 transition-colors">
              <span class="material-symbols-outlined text-lg">close</span>
            </button>
          </div>

          <!-- Cuerpo con Scroll Interno -->
          <div class="overflow-y-auto pr-1 custom-scrollbar flex-grow space-y-4 my-1">
            <form id="profileForm" @submit.prevent="handleCompleteProfile" class="space-y-4">
              
              <!-- Grid de Inputs del Perfil -->
              <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                <div>
                  <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mb-1 ml-1">Nombres</label>
                  <input v-model="profileForm.nombres" type="text" required placeholder="Nombres" class="input-cyber w-full bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 focus:border-accent-neon rounded-xl p-2.5 text-xs text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-white/30" />
                </div>

                <div>
                  <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mb-1 ml-1">Apellidos</label>
                  <input v-model="profileForm.apellidos" type="text" required placeholder="Apellidos" class="input-cyber w-full bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 focus:border-accent-neon rounded-xl p-2.5 text-xs text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-white/30" />
                </div>

                <div>
                  <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mb-1 ml-1">Correo Electrónico</label>
                  <input :value="authStore.user?.correo" type="email" readonly class="input-cyber w-full bg-gray-200/50 dark:bg-white/[0.02] border border-transparent rounded-xl p-2.5 text-xs text-gray-500 dark:text-white/40 cursor-not-allowed select-none" />
                </div>

                <div>
                  <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mb-1 ml-1">Cédula / DNI</label>
                  <input v-model="profileForm.ci" type="text" required placeholder="Ej. 8493021" class="input-cyber w-full bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 focus:border-accent-neon rounded-xl p-2.5 text-xs text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-white/30" />
                </div>

                <div>
                  <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mb-1 ml-1">WhatsApp / Celular</label>
                  <input v-model="profileForm.telefono" type="text" required placeholder="Ej. 76543210" class="input-cyber w-full bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 focus:border-accent-neon rounded-xl p-2.5 text-xs text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-white/30" />
                </div>

                <div class="relative">
                  <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mb-1 ml-1">Contraseña (Opcional)</label>
                  <div class="relative">
                    <input v-model="profileForm.contrasena" :type="showPassword ? 'text' : 'password'" placeholder="••••••••" class="input-cyber w-full bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 focus:border-accent-neon rounded-xl p-2.5 pr-9 text-xs text-gray-900 dark:text-white placeholder-gray-400 dark:placeholder-white/30" />
                    <button type="button" @click="showPassword = !showPassword" tabindex="-1" class="absolute right-2.5 top-1/2 -translate-y-1/2 text-gray-400 dark:text-white/30 hover:text-accent-neon transition-colors">
                      <span class="material-symbols-outlined text-lg">{{ showPassword ? 'visibility_off' : 'visibility' }}</span>
                    </button>
                  </div>
                </div>
              </div>

              <!-- Sección de Pago -->
              <div v-if="requiresPayment" class="pt-3 border-t border-gray-200 dark:border-white/10 space-y-3">
                
                <!-- Encabezado con Monto -->
                <div class="flex items-center justify-between bg-gray-100 dark:bg-white/5 px-3.5 py-2.5 rounded-xl">
                  <div>
                    <p class="text-[10px] font-black uppercase tracking-[0.15em] text-gray-500 dark:text-white/40">Pago del curso</p>
                    <p class="text-[11px] text-gray-600 dark:text-white/60">Selecciona tu método de pago preferido</p>
                  </div>
                  <div class="text-right">
                    <span class="text-[10px] text-gray-500 dark:text-white/50 inline-block mr-1">Monto:</span>
                    <span class="text-base font-black text-accent-neon">{{ selectedCoursePrecio.toFixed(2) }} BS</span>
                  </div>
                </div>

                <!-- Selector de Métodos de Pago -->
                <div class="grid grid-cols-3 gap-2">
                  <button type="button" @click="paymentMethod = 'QR'" 
                          class="p-2 rounded-xl text-center border transition-all flex flex-col sm:flex-row items-center justify-center gap-1.5"
                          :class="paymentMethod === 'QR' ? 'bg-accent-neon/10 border-accent-neon text-accent-neon font-bold' : 'bg-gray-100 dark:bg-white/5 border-gray-200 dark:border-white/10 text-gray-600 dark:text-white/60 hover:border-gray-300 dark:hover:border-white/20'">
                    <span class="material-symbols-outlined text-base">qr_code_2</span>
                    <span class="text-[11px]">Código QR</span>
                  </button>

                  <button type="button" @click="paymentMethod = 'transfer'" 
                          class="p-2 rounded-xl text-center border transition-all flex flex-col sm:flex-row items-center justify-center gap-1.5"
                          :class="paymentMethod === 'transfer' ? 'bg-accent-neon/10 border-accent-neon text-accent-neon font-bold' : 'bg-gray-100 dark:bg-white/5 border-gray-200 dark:border-white/10 text-gray-600 dark:text-white/60 hover:border-gray-300 dark:hover:border-white/20'">
                    <span class="material-symbols-outlined text-base">account_balance</span>
                    <span class="text-[11px]">Transferencia</span>
                  </button>

                  <button type="button" @click="paymentMethod = 'deposit'" 
                          class="p-2 rounded-xl text-center border transition-all flex flex-col sm:flex-row items-center justify-center gap-1.5"
                          :class="paymentMethod === 'deposit' ? 'bg-accent-neon/10 border-accent-neon text-accent-neon font-bold' : 'bg-gray-100 dark:bg-white/5 border-gray-200 dark:border-white/10 text-gray-600 dark:text-white/60 hover:border-gray-300 dark:hover:border-white/20'">
                    <span class="material-symbols-outlined text-base">payments</span>
                    <span class="text-[11px]">Depósito</span>
                  </button>
                </div>

                <!-- Contenido dinámico según el Método Seleccionado -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-3 items-center">
                  
                  <!-- Opción 1: Vista QR con Opciones de Ampliar y Descargar -->
                  <div v-if="paymentMethod === 'QR'" class="rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 p-3 flex flex-col items-center text-center relative group">
                    
                    <!-- Imagen QR interactiva -->
                    <div class="relative cursor-pointer overflow-hidden rounded-lg group/img" @click="showZoomQr = true">
                      <img src="/images/qr-pago.jpeg" alt="Código QR de pago" class="w-36 max-w-full h-auto object-contain transition-transform duration-300 group-hover/img:scale-105" />
                      <!-- Overlay al hacer Hover para indicar Zoom -->
                      <div class="absolute inset-0 bg-black/40 opacity-0 group-hover/img:opacity-100 flex items-center justify-center text-white transition-opacity">
                        <span class="material-symbols-outlined text-2xl">zoom_in</span>
                      </div>
                    </div>

                    <!-- Botones de Acción Rápida (Ampliar + Descargar) -->
                    <div class="flex items-center gap-2 mt-2">
                      <button type="button" @click="showZoomQr = true" 
                              class="px-2.5 py-1 rounded-lg bg-gray-200 dark:bg-white/10 text-gray-700 dark:text-white/80 hover:text-accent-neon hover:bg-accent-neon/10 text-[10px] font-bold flex items-center gap-1 transition-colors"
                              title="Ampliar QR">
                        <span class="material-symbols-outlined text-sm">zoom_in</span>
                        <span>Ampliar</span>
                      </button>

                      <a href="/images/qr-pago.jpeg" download="QR-Pago-Enervida.jpeg" 
                         class="px-2.5 py-1 rounded-lg bg-gray-200 dark:bg-white/10 text-gray-700 dark:text-white/80 hover:text-accent-neon hover:bg-accent-neon/10 text-[10px] font-bold flex items-center gap-1 transition-colors"
                         title="Guardar o descargar QR">
                        <span class="material-symbols-outlined text-sm">download</span>
                        <span>Guardar</span>
                      </a>
                    </div>
                  </div>

                  <!-- Opción 2 y 3: Datos Bancarios -->
                  <div v-else class="rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 p-3.5 space-y-2 text-xs">
                    <div class="flex items-center justify-between border-b border-gray-200 dark:border-white/10 pb-1.5">
                      <span class="text-[10px] uppercase font-bold text-gray-400 dark:text-white/40">Banco</span>
                      <span class="font-bold text-gray-800 dark:text-white">Banco Union S.A.</span>
                    </div>
                    <div class="flex items-center justify-between border-b border-gray-200 dark:border-white/10 pb-1.5">
                      <span class="text-[10px] uppercase font-bold text-gray-400 dark:text-white/40">Nº de Cuenta</span>
                      <span class="font-mono font-bold text-accent-neon">10000012345678</span>
                    </div>
                    <div class="flex items-center justify-between border-b border-gray-200 dark:border-white/10 pb-1.5">
                      <span class="text-[10px] uppercase font-bold text-gray-400 dark:text-white/40">Titular</span>
                      <span class="font-medium text-gray-800 dark:text-white">Jhonatan Ramos</span>
                    </div>
                    <p class="text-[9px] text-gray-500 dark:text-white/50 pt-0.5">
                      {{ paymentMethod === 'transfer' ? 'Realiza la transferencia e ingresa el comprobante.' : 'Realiza el depósito en ventanilla/cajero y sube la foto del ticket.' }}
                    </p>
                  </div>

                  <!-- Upload de Comprobante -->
                  <div class="space-y-2">
                    <label class="block text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Comprobante de Pago</label>
                    <label class="flex flex-col items-center justify-center p-4 border-2 border-dashed border-gray-300 dark:border-white/20 hover:border-accent-neon dark:hover:border-accent-neon bg-gray-50 dark:bg-white/5 rounded-xl cursor-pointer transition-colors group">
                      <span class="material-symbols-outlined text-2xl text-gray-400 dark:text-white/30 group-hover:text-accent-neon transition-colors mb-1">cloud_upload</span>
                      <span class="text-xs font-semibold text-gray-700 dark:text-white/80 group-hover:text-accent-neon transition-colors text-center">
                        {{ comprobanteFile ? comprobanteFile.name : 'Haz clic o arrastra tu comprobante' }}
                      </span>
                      <span class="text-[9px] text-gray-400 dark:text-white/40 mt-0.5">JPG, PNG, PDF</span>
                      <input type="file" accept="image/*,.pdf" @change="handleComprobanteFileChange" class="hidden" />
                    </label>
                    <p v-if="comprobantePagoUrl" class="text-[10px] text-accent-neon font-medium flex items-center gap-1">
                      <span class="material-symbols-outlined text-xs">check_circle</span> Comprobante subido.
                    </p>
                  </div>

                </div>
              </div>

            </form>
          </div>

          <!-- Pie de página Fijo -->
          <div class="pt-3 mt-1 border-t border-gray-200 dark:border-white/10 flex flex-col-reverse sm:flex-row justify-end items-center gap-2 shrink-0">
            <button type="button" @click="cancelEnroll" class="w-full sm:w-auto px-5 py-2.5 rounded-xl text-xs font-black uppercase tracking-widest text-gray-500 dark:text-white/50 hover:text-gray-800 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-white/5 transition-colors">
              Cancelar
            </button>
            <button type="submit" form="profileForm" :disabled="savingProfile" class="w-full sm:w-auto min-w-[200px] px-5 py-2.5 rounded-xl bg-accent-neon text-background text-xs font-black uppercase tracking-widest shadow-md hover:shadow-accent-neon/20 hover:-translate-y-0.5 active:scale-95 transition-all disabled:opacity-50 flex items-center justify-center gap-2">
              <span>{{ savingProfile ? 'Procesando...' : 'Confirmar datos y solicitar' }}</span>
              <span v-if="savingProfile" class="material-symbols-outlined animate-spin text-sm">sync</span>
            </button>
          </div>

        </div>
      </div>
    </transition>

    <!-- Visor Flotante para Ampliar el QR (Lightbox Modal) -->
    <transition name="fade">
      <div v-if="showZoomQr" class="fixed inset-0 z-[300] flex items-center justify-center bg-black/80 backdrop-blur-md p-4" @click="showZoomQr = false">
        <div class="relative max-w-sm w-full bg-white dark:bg-surface border border-gray-200 dark:border-white/10 p-4 rounded-2xl flex flex-col items-center gap-3 shadow-2xl" @click.stop>
          <button type="button" @click="showZoomQr = false" class="absolute top-2 right-2 p-1 text-gray-400 hover:text-gray-900 dark:hover:text-white">
            <span class="material-symbols-outlined text-xl">close</span>
          </button>
          <h3 class="text-xs font-black uppercase tracking-wider text-gray-700 dark:text-white/80 mt-1">Escanear Código QR</h3>
          <img src="/images/qr-pago.jpeg" alt="Código QR Ampliado" class="w-full h-auto object-contain rounded-xl" />
          <a href="/images/qr-pago.jpeg" download="QR-Pago-Enervida.jpeg" 
             class="w-full py-2 bg-accent-neon text-background font-black text-xs uppercase tracking-widest rounded-xl text-center shadow hover:opacity-90 transition-opacity">
            Descargar Imagen
          </a>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '@/services/api'
import { getFileUrl } from '@/config'
import { useAuthStore } from '@/stores/auth'
import AppLogo from '@/components/global/AppLogo.vue'
import ThemeToggle from '@/components/global/ThemeToggle.vue'
import NotificationDropdown from '@/components/global/NotificationDropdown.vue'
import { useModalStore } from '@/stores/modalStore'
import { useNotificationStore } from '@/stores/notificationStore'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()
const modalStore = useModalStore()
const notificationStore = useNotificationStore()

const inscripciones = ref([])
const catalogCursos = ref([])
const liveClasses = ref([])
const notifications = ref([])
const loading = ref(true)
const profileImageFailed = ref(false)
const isMobileMenuOpen = ref(false)
const showCompleteProfile = ref(false)
const savingProfile = ref(false)
const showPassword = ref(false)
const selectedCourseId = ref(null)
const paymentMethod = ref('QR')
const showZoomQr = ref(false)
const comprobantePagoUrl = ref('')
const comprobanteFile = ref(null)
const uploadingComprobante = ref(false)
const profileForm = ref({
  nombres: '',
  apellidos: '',
  ci: '',
  telefono: '',
  contrasena: '',
})

const navLinks = [
  { text: 'Inicio', id: 'dashboard', to: '/student/dashboard' },
  { text: 'Catálogo', id: 'catalog', to: '/student/catalog' },
  { text: 'Mis Cursos', id: 'my-courses', to: '/student/my-courses' },
  { text: 'Laboratorios', id: 'labs', to: '/student/labs' },
  { text: 'Certificados', id: 'certificates', to: '/student/certificates' },
  { text: 'En Vivo', id: 'live-classes', to: '/student/live-classes' },
]

const enrolledCourseIds = computed(() => new Set(
  inscripciones.value
    .filter((ins) => ins.estado === 'ACTIVO' || ins.estado === 'PENDIENTE')
    .map((ins) => ins.curso_id || ins.curso?.id)
))
const availableCourses = computed(() => catalogCursos.value)
const selectedCourse = computed(() => catalogCursos.value.find((curso) => curso.id === selectedCourseId.value) || null)
const selectedCoursePrecio = computed(() => Number(selectedCourse.value?.precio ?? 0))
const requiresPayment = computed(() => selectedCoursePrecio.value > 0)
const ultimoCurso = computed(() => {
  const activas = inscripciones.value.filter((ins) => ins.estado === 'ACTIVO' && ins.porcentaje_progreso < 100)
  return [...activas].sort((a, b) => (b.id || 0) - (a.id || 0))[0] || null
})

const userInitials = computed(() => {
  const nombres = authStore.user?.nombres || ''
  const apellidos = authStore.user?.apellidos || ''
  const initials = `${nombres.charAt(0)}${apellidos.charAt(0)}`.trim()
  return initials ? initials.toUpperCase() : 'ES'
})

const currentNavLabel = computed(() => {
  const current = navLinks.find((link) => isStudentRoute(link.to))
  return current?.text || 'Mi campus'
})

const profileImageUrl = computed(() => getFileUrl(
  authStore.user?.imagen_perfil ||
  authStore.user?.foto ||
  authStore.user?.picture ||
  authStore.user?.avatar
))

watch(profileImageUrl, () => {
  profileImageFailed.value = false
})

watch(isMobileMenuOpen, (open) => {
  document.body.style.overflow = open ? 'hidden' : ''
})

watch(showCompleteProfile, (open) => {
  document.body.style.overflow = open ? 'hidden' : ''
})

// Bloquea el scroll del fondo cuando el modal global (cerrar sesión, éxito, etc.) se abre
watch(() => modalStore.isOpen, (open) => {
  document.body.style.overflow = open ? 'hidden' : ''
})

watch(() => route.path, () => {
  isMobileMenuOpen.value = false
})

onMounted(() => {
  fetchStudentData()
})

onUnmounted(() => {
  document.body.style.overflow = ''
})

function getIconForRoute(id) {
  const icons = {
    'dashboard': 'home',
    'catalog': 'explore',
    'my-courses': 'play_circle',
    'labs': 'science',
    'certificates': 'workspace_premium',
    'live-classes': 'sensors'
  }
  return icons[id] || 'circle'
}

function normalizeArray(value) {
  return Array.isArray(value) ? value : []
}

function isStudentRoute(path) {
  if (path === '/student/dashboard') return route.path === path
  return route.path.startsWith(path)
}

async function safeGet(endpoint) {
  try {
    const response = await api.get(endpoint)
    return normalizeArray(response.data)
  } catch (error) {
    console.warn(`No se pudo cargar ${endpoint}:`, error.response?.status || error.message)
    return []
  }
}

async function fetchStudentData() {
  loading.value = true
  try {
    const [insData, catData, liveData, notifData] = await Promise.all([
      safeGet('/inscripciones/me'),
      safeGet('/cursos/public'),
      safeGet('/clases-en-vivo'),
      safeGet('/notificaciones'),
    ])

    inscripciones.value = insData
    catalogCursos.value = catData
    liveClasses.value = liveData.filter((clase) => {
      const courseId = clase.curso_id || clase.curso?.id
      return !courseId || enrolledCourseIds.value.has(courseId)
    })
    notifications.value = notifData.filter((notif) => !notif.usuario_id || notif.usuario_id === authStore.user?.id || notif.usuario?.id === authStore.user?.id)
  } finally {
    loading.value = false
  }
}

function formatDate(value) {
  if (!value) return 'Sin fecha'
  return new Date(value).toLocaleDateString('es-BO', { day: '2-digit', month: 'short' })
}

function formatTime(value) {
  if (!value) return ''
  return new Date(value).toLocaleTimeString('es-BO', { hour: '2-digit', minute: '2-digit' })
}

function resetPaymentFields() {
  paymentMethod.value = 'QR'
  comprobantePagoUrl.value = ''
  comprobanteFile.value = null
  uploadingComprobante.value = false
}

function handleComprobanteFileChange(event) {
  const file = event.target.files?.[0] || null
  comprobanteFile.value = file
  if (file) {
    comprobantePagoUrl.value = ''
  }
}

async function uploadComprobante() {
  if (!comprobanteFile.value) return null
  uploadingComprobante.value = true

  try {
    const formData = new FormData()
    formData.append('file', comprobanteFile.value)
    formData.append('folder', 'comprobantes')

    const response = await api.post('/uploads', formData)
    return response.data.url
  } catch (error) {
    console.error('Error al subir comprobante:', error)
    const msg = error.response?.data?.message || 'No se pudo subir el comprobante.'
    notificationStore.addNotification({
      title: 'Error de Comprobante',
      message: msg,
      type: 'error'
    })
    throw error
  } finally {
    uploadingComprobante.value = false
  }
}

async function createEnrollment(cursoId) {
  try {
    const payload = {
      usuario_id: authStore.user.id,
      curso_id: cursoId,
      estado_pago: requiresPayment.value ? 'PENDIENTE' : 'APROBADO',
    }

    if (requiresPayment.value) {
      payload.metodo_pago = paymentMethod.value
      payload.comprobante_pago_url = comprobantePagoUrl.value
      if (comprobantePagoUrl.value) {
        payload.fecha_pago = new Date().toISOString()
      }
    }

    await api.post('/inscripciones', payload)

    showCompleteProfile.value = false

    modalStore.openModal({
      title: '¡Solicitud Enviada!',
      message: requiresPayment.value
        ? 'Tu solicitud y comprobante fueron enviados. El administrador revisará el pago y aprobará tu acceso.'
        : 'Tu inscripción estará activa una vez confirmada por el administrador. Te avisaremos por correo.',
      confirmText: 'Entendido',
      type: 'success',
      onConfirm: () => {
        router.push('/student/dashboard')
      }
    })

    resetPaymentFields()
    selectedCourseId.value = null
    await fetchStudentData()
  } catch (error) {
    console.error('Error enrolling in course:', error)
    console.error('Server response data:', error.response?.data)
    const serverMsg = error.response?.data?.message || error.response?.data || null
    const msg = serverMsg || 'Ya tienes una solicitud pendiente o ya estas inscrito en este curso.'
    notificationStore.addNotification({
      title: 'Inscripción Fallida',
      message: typeof msg === 'string' ? msg : JSON.stringify(msg),
      type: 'error'
    })
    selectedCourseId.value = null
  }
}

function handleLogout() {
  modalStore.openModal({
    title: 'Cerrar sesión',
    message: '¿Deseas cerrar sesión y volver a la pantalla de inicio? Tu sesión actual se cerrará.',
    confirmText: 'Cerrar sesión',
    cancelText: 'Cancelar',
    type: 'danger',
    onConfirm: async () => {
      await authStore.logout()
      router.push('/')
    }
  })
}

async function handleCompleteProfile() {
  savingProfile.value = true
  try {
    const needsInfo = !authStore.user?.ci || !authStore.user?.telefono

    if (needsInfo) {
      const payload = {
        nombres: profileForm.value.nombres,
        apellidos: profileForm.value.apellidos,
        ci: String(profileForm.value.ci).trim(),
        telefono: String(profileForm.value.telefono).trim(),
      }

      if (profileForm.value.contrasena) {
        payload.contrasena = profileForm.value.contrasena
      }

      const response = await api.patch('/usuarios/profile', payload)
      await authStore.updateUser({
        ...response.data,
        hasPassword: !!payload.contrasena || authStore.user?.hasPassword
      })
    }

    if (requiresPayment.value && !comprobantePagoUrl.value && !comprobanteFile.value) {
      notificationStore.addNotification({
        title: 'Comprobante requerido',
        message: 'Debes adjuntar el comprobante de pago para solicitar este curso.',
        type: 'warning'
      })
      return
    }

    if (requiresPayment.value && comprobanteFile.value && !comprobantePagoUrl.value) {
      comprobantePagoUrl.value = await uploadComprobante()
    }

    if (selectedCourseId.value) {
      await createEnrollment(selectedCourseId.value)
    }
  } catch (error) {
    console.error('Error updating profile:', error)
    const msg = error.response?.data?.message || 'Error al actualizar el perfil.'
    notificationStore.addNotification({
      title: 'Error de Perfil',
      message: msg,
      type: 'error'
    })
  } finally {
    savingProfile.value = false
  }
}

async function enrollInCourse(cursoId) {
  selectedCourseId.value = cursoId
  const needsInfo = !authStore.user?.ci || !authStore.user?.telefono

  if (needsInfo || requiresPayment.value) {
    profileForm.value.nombres = authStore.user?.nombres || ''
    profileForm.value.apellidos = authStore.user?.apellidos || ''
    profileForm.value.ci = authStore.user?.ci || ''
    profileForm.value.telefono = authStore.user?.telefono || ''
    profileForm.value.contrasena = ''
    resetPaymentFields()
    showCompleteProfile.value = true
    return
  }

  await createEnrollment(cursoId)
}

function cancelEnroll() {
  showCompleteProfile.value = false
  selectedCourseId.value = null
  resetPaymentFields()
}
</script>

<style scoped>
.panel-hero {
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--accent-neon) 12%, transparent 88%) 0%, transparent 36%),
    linear-gradient(135deg, color-mix(in srgb, var(--surface-container) 94%, transparent 6%) 0%, color-mix(in srgb, var(--background) 82%, var(--surface-container) 18%) 100%);
  box-shadow: 0 30px 60px -30px var(--clay-shadow-dark);
}

@keyframes popIn {
  0% {
    opacity: 0;
    transform: translateY(20px) scale(0.9);
  }
  100% {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.animate-pop-in {
  opacity: 0;
  animation: popIn 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}
</style>
