<template>
  <div class="outage-page" @mousemove="onMouseMove">
    <div class="noise"></div>
    <div class="scanline"></div>
    <div class="horizon horizon-one"></div>
    <div class="horizon horizon-two"></div>

    <!-- Flash de tormenta (overlay) -->
    <div class="storm-flash" :class="{ 'storm-flash--active': isStorming }"></div>

    <header class="outage-header">
      <router-link to="/" class="brand" aria-label="Ir al inicio de Enervida">
        <span class="brand-mark">
          <i></i><i></i><i></i>
        </span>
        <span>Ops.!</span>
      </router-link>
      <p class="location"><span></span> Error · {{ elapsed }}</p>
    </header>

    <main class="outage-content">
      <section class="incident-copy" aria-labelledby="incident-title">
        <p class="eyebrow"><span class="live-dot"></span> SECTOR 404 · FUERA DE COBERTURA</p>
        <h1 id="incident-title">Esta página<br><em>está en sombra.</em></h1>

        <blockquote class="callout">
          <span class="callout-quote" aria-hidden="true">&ldquo;</span>
          <p>Una nube se posó sobre este sector.</p>
          <cite>— Bitácora de planta, {{ elapsed }}</cite>
        </blockquote>

        <p class="description">
          No encontramos la ruta que buscás. Mientras tanto, el resto de la red
          Enervida sigue generando energía en otros sectores.
        </p>

        <div class="actions">
          <router-link to="/" class="primary-action">
            <span>Activar otro sector</span>
            <b>→</b>
          </router-link>
          <button type="button" class="secondary-action" @click="$router.back()">← Sector anterior</button>
        </div>

        <!-- Mini panel de telemetría -->
        <ul class="telemetry" aria-label="Telemetría del incidente">
          <li>
            <span class="telemetry-label">Pérdida</span>
            <strong class="telemetry-value">{{ loss.toFixed(1) }} <em>kW</em></strong>
          </li>
          <li>
            <span class="telemetry-label">Sectores</span>
            <strong class="telemetry-value">{{ affectedSectors }} <em>/48</em></strong>
          </li>
          <li>
            <span class="telemetry-label">Próximo intento</span>
            <strong class="telemetry-value">{{ nextRetry }}<em>s</em></strong>
          </li>
        </ul>
      </section>

      <section class="incident-visual" aria-label="Panel de estado de conexión">
        <div class="solar-glow"></div>
        <div class="signal-rings"><i></i><i></i><i></i></div>

        <svg class="power-lines" viewBox="0 0 640 520" fill="none" aria-hidden="true">
          <path class="line line-back" d="M0 155C120 155 129 320 249 320H640" />
          <path class="line line-front" d="M0 86C138 86 148 261 287 261H640" />
          <path class="line line-lower" d="M0 429C175 429 211 355 353 355H640" />
          <path class="line-current current-one" d="M0 86C138 86 148 261 287 261H640" />
          <path class="line-current current-two" d="M0 429C175 429 211 355 353 355H640" />
        </svg>

        <!-- ====== NUBE + LLUVIA + RAYO ====== -->
        <div class="cloud-wrap" :style="cloudStyle">
          <!-- Cumulus: varias formas -->
          <div class="cloud" :class="{ 'cloud--lit': flashTick }">
            <span class="cs cs-1"></span>
            <span class="cs cs-2"></span>
            <span class="cs cs-3"></span>
            <span class="cs cs-4"></span>
            <span class="cs cs-5"></span>
            <span class="cs cs-6"></span>
            <span class="cs cs-7"></span>
            <span class="cs-highlight"></span>
          </div>

          <!-- Lluvia -->
          <div class="rain" aria-hidden="true">
            <span
              v-for="(d, i) in drops"
              :key="i"
              class="drop"
              :style="{
                left: d.left + '%',
                animationDelay: d.delay + 's',
                animationDuration: d.duration + 's',
                opacity: d.opacity
              }"
            ></span>
          </div>

          <!-- Relámpago zigzag -->
          <svg
            class="lightning"
            :class="{ 'lightning--on': flashTick }"
            viewBox="0 0 80 220"
            aria-hidden="true">
            <defs>
              <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
                <feGaussianBlur stdDeviation="3" result="blur" />
                <feMerge>
                  <feMergeNode in="blur" />
                  <feMergeNode in="SourceGraphic" />
                </feMerge>
              </filter>
            </defs>
            <path
              d="M 40 0 L 36 70 L 50 80 L 32 140 L 48 152 L 28 220"
              stroke="var(--lime)" stroke-width="2.2" fill="none"
              stroke-linecap="round" stroke-linejoin="round"
              filter="url(#glow)" />
            <path
              d="M 40 0 L 36 70 L 50 80 L 32 140 L 48 152 L 28 220"
              stroke="#ffffff" stroke-width="0.8" fill="none"
              stroke-linecap="round" stroke-linejoin="round" opacity="0.9" />
          </svg>
        </div>

        <!-- Sombra de la nube en el suelo -->
        <div class="ground-shadow" :class="{ 'ground-shadow--pulse': flashTick }"></div>

        <!-- ====== PANEL SOLAR (montado en la torre) ====== -->
        <div class="solar-panel" :class="{ 'solar-panel--shaded': flashTick }" aria-hidden="true">
          <span class="sp-frame"></span>
          <span class="sp-cells">
            <i v-for="n in 24" :key="n" class="sp-cell"></i>
          </span>
          <span class="sp-glow"></span>
          <span class="sp-cable"></span>
          <span class="sp-id">PV-01</span>
        </div>

        <!-- ====== ANTENA ====== -->
        <div class="tower" aria-hidden="true">
          <div class="tower-cap"></div>
          <div class="tower-body">
            <i class="tower-leg leg-left"></i>
            <i class="tower-leg leg-right"></i>
            <i class="cross cross-top"></i>
            <i class="cross cross-middle"></i>
            <i class="cross cross-bottom"></i>
          </div>
          <div class="insulators insulators-top"><i></i><i></i></div>
          <div class="insulators insulators-bottom"><i></i><i></i></div>
        </div>

        <!-- ====== FAULT CARD ====== -->
        <div class="fault-card" :class="{ 'fault-card--storm': flashTick }">
          <div class="fault-status"><span></span> {{ faultLabel }}</div>
          <strong>404</strong>
          <p>{{ faultSub }}</p>
          <div class="fault-meter" :class="{ 'fault-meter--storm': flashTick }">
            <i></i><i></i><i></i><i></i><i></i><i></i><i></i>
          </div>
        </div>

        <!-- Chispas -->
        <div class="spark spark-one">✦</div>
        <div class="spark spark-two">✦</div>
        <div class="spark spark-three">✦</div>
      </section>
    </main>

    <footer class="outage-footer">
      <span>ENERVIDA / ENERGÍA QUE DA VIDA</span>
      <span>ESTADO: <b>{{ statusLabel }}</b></span>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'

// === Parallax del mouse ===
const mouseX = ref(0)
const mouseY = ref(0)
const cloudStyle = computed(() => ({
  '--mx': mouseX.value.toFixed(2),
  '--my': mouseY.value.toFixed(2)
}))

function onMouseMove(e) {
  const cx = window.innerWidth / 2
  const cy = window.innerHeight / 2
  mouseX.value = (e.clientX - cx) * 0.025
  mouseY.value = (e.clientY - cy) * 0.012
}

// === Flash de tormenta (rayo) ===
const flashTick = ref(false)
let flashInterval = null
function triggerFlash() {
  flashTick.value = true
  setTimeout(() => (flashTick.value = false), 180)
  // a veces doble flash
  if (Math.random() > 0.55) {
    setTimeout(() => {
      flashTick.value = true
      setTimeout(() => (flashTick.value = false), 140)
    }, 220)
  }
}
onMounted(() => {
  flashInterval = setInterval(() => {
    if (Math.random() < 0.85) triggerFlash()
  }, 3200)
})
onUnmounted(() => clearInterval(flashInterval))

const isStorming = computed(() => flashTick.value)

// === Lluvia: 28 gotas con parámetros aleatorios ===
const drops = Array.from({ length: 28 }, () => ({
  left: Math.random() * 100,
  delay: Math.random() * 1.2,
  duration: 0.55 + Math.random() * 0.5,
  opacity: 0.35 + Math.random() * 0.55
}))

// === Tiempo transcurrido desde el incidente ===
const startMs = Date.now()
const elapsed = ref('00:00')
let elapsedInterval = null
function tickElapsed() {
  const s = Math.floor((Date.now() - startMs) / 1000)
  const m = String(Math.floor(s / 60)).padStart(2, '0')
  const ss = String(s % 60).padStart(2, '0')
  elapsed.value = `${m}:${ss}`
}
onMounted(() => {
  tickElapsed()
  elapsedInterval = setInterval(tickElapsed, 1000)
})
onUnmounted(() => clearInterval(elapsedInterval))

// === Telemetría reactiva ===
const loss = ref(2.4)
const affectedSectors = ref(3)
const nextRetry = ref(12)
let telemetryInterval = null
onMounted(() => {
  telemetryInterval = setInterval(() => {
    loss.value = 2.0 + Math.random() * 1.0
    affectedSectors.value = 2 + Math.floor(Math.random() * 3)
    nextRetry.value = 8 + Math.floor(Math.random() * 9)
  }, 1800)
})
onUnmounted(() => clearInterval(telemetryInterval))

// === Labels dinámicos del fault card ===
const faultLabel = computed(() => (flashTick.value ? 'TORMENTA EN CURSO' : 'PANEL SIN SEÑAL'))
const faultSub = computed(() => (flashTick.value ? 'DESCARGA DETECTADA' : 'NUBE SOBRE EL SECTOR'))
const statusLabel = computed(() => (flashTick.value ? 'RIESGO DE DESCARGA' : 'PANEL EN SOMBRA'))
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Manrope:wght@400;500;600;700;800&display=swap');

.outage-page {
  --ink: #eaf0df;
  --muted: #92a094;
  --lime: #d4ff45;
  --orange: #ff7951;
  --cloud-base: #1a2030;
  --cloud-shadow: #0d111c;
  --cloud-light: #2c3548;
  position: relative;
  min-height: 100vh;
  overflow: hidden;
  isolation: isolate;
  padding: 1.6rem clamp(1.25rem, 5vw, 5rem) 1.35rem;
  display: flex;
  flex-direction: column;
  background: #07100e;
  color: var(--ink);
  font-family: 'Manrope', sans-serif;
}

.outage-page::before {
  content: '';
  position: absolute;
  z-index: -4;
  inset: 0;
  background:
    radial-gradient(ellipse 50% 45% at 72% 49%, rgba(161, 218, 44, .16), transparent 72%),
    radial-gradient(ellipse 30% 34% at 21% 100%, rgba(255, 119, 75, .14), transparent 75%),
    linear-gradient(118deg, #07100e 4%, #0b1711 55%, #07100e 100%);
}

.noise,
.scanline,
.horizon { position: absolute; pointer-events: none; }

.noise {
  z-index: -1;
  inset: 0;
  opacity: .09;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 180 180' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='.7'/%3E%3C/svg%3E");
}

.scanline {
  z-index: 4;
  inset: -30% 0 auto;
  height: 14%;
  opacity: .14;
  background: linear-gradient(180deg, transparent, rgba(212, 255, 69, .12), transparent);
  animation: scan 7s linear infinite;
}

.horizon {
  z-index: -2;
  width: 130%;
  height: 1px;
  left: -15%;
  background: linear-gradient(90deg, transparent, rgba(212, 255, 69, .3), transparent);
  transform: rotate(-11deg);
}
.horizon-one { top: 36%; }
.horizon-two { top: 75%; opacity: .25; transform: rotate(8deg); }

/* ===== Flash de tormenta (overlay) ===== */
.storm-flash {
  position: fixed;
  inset: 0;
  background:
    radial-gradient(ellipse 60% 50% at 50% 35%, rgba(212, 255, 69, .25), transparent 70%),
    rgba(212, 255, 69, .08);
  pointer-events: none;
  z-index: 50;
  opacity: 0;
  transition: opacity .12s ease-out;
  mix-blend-mode: screen;
}
.storm-flash--active { opacity: 1; }

.outage-header,
.outage-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  z-index: 5;
}

.brand { display: inline-flex; align-items: center; gap: .65rem; color: var(--ink); text-decoration: none; font-size: 1.17rem; font-weight: 800; letter-spacing: -.06em; }
.brand-mark { width: 25px; height: 25px; position: relative; display: inline-flex; gap: 2px; align-items: end; transform: skewX(-12deg); }
.brand-mark i { display: block; width: 6px; background: var(--lime); border-radius: 1px; box-shadow: 0 0 9px rgba(212,255,69,.65); }
.brand-mark i:nth-child(1) { height: 10px; }.brand-mark i:nth-child(2) { height: 18px; }.brand-mark i:nth-child(3) { height: 25px; }
.location, .outage-footer { margin: 0; color: var(--muted); font: 500 .61rem/1 'DM Mono', monospace; letter-spacing: .13em; }
.location { display: flex; align-items: center; gap: .45rem; }
.location span { width: 6px; height: 6px; border-radius: 50%; background: var(--lime); box-shadow: 0 0 10px var(--lime); animation: blink 1.7s ease-in-out infinite; }

.outage-content { flex: 1; width: min(100%, 1200px); margin: 0 auto; display: grid; grid-template-columns: .94fr 1.06fr; align-items: center; gap: clamp(2rem, 6vw, 7rem); }
.incident-copy { position: relative; z-index: 3; padding-top: 2rem; }
.eyebrow { display: flex; align-items: center; gap: .6rem; margin: 0 0 1.25rem; color: var(--orange); font: 500 .68rem/1 'DM Mono', monospace; letter-spacing: .08em; }
.live-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--orange); box-shadow: 0 0 0 0 rgba(255,121,81,.6); animation: alertPulse 1.5s infinite; }
h1 { max-width: 600px; margin: 0; color: var(--ink); font-size: clamp(3.1rem, 6.5vw, 6.3rem); font-weight: 700; letter-spacing: -.075em; line-height: .93; }
h1 em { color: var(--lime); font-weight: 400; font-style: normal; text-shadow: 0 0 28px rgba(212,255,69,.22); }
.description { max-width: 450px; margin: 1.4rem 0 0; color: #aeb9ab; font-size: .98rem; line-height: 1.75; }

/* ===== Callout destacado ===== */
.callout {
  position: relative;
  margin: 1.6rem 0 0;
  padding: 1rem 1.2rem 1rem 1.6rem;
  max-width: 450px;
  background: linear-gradient(135deg, rgba(212, 255, 69, .04), rgba(212, 255, 69, .01));
  border-left: 3px solid var(--lime);
  font-family: 'Manrope', sans-serif;
}
.callout-quote {
  position: absolute;
  top: -8px;
  left: 8px;
  font: 700 4.5rem/1 'Manrope', sans-serif;
  color: var(--lime);
  opacity: .22;
  pointer-events: none;
  user-select: none;
}
.callout p {
  position: relative;
  margin: 0;
  color: var(--ink);
  font: 500 1.18rem/1.4 'Manrope', sans-serif;
  letter-spacing: -.01em;
}
.callout cite {
  display: block;
  margin-top: .55rem;
  color: var(--muted);
  font: 500 .62rem/1 'DM Mono', monospace;
  letter-spacing: .12em;
  font-style: normal;
  text-transform: uppercase;
}
.actions { display: flex; align-items: center; flex-wrap: wrap; gap: 1.1rem; margin-top: 2rem; }
.primary-action, .secondary-action { text-decoration: none; font-size: .82rem; font-weight: 800; transition: transform .25s ease, background .25s ease; }
.primary-action { display: inline-flex; align-items: center; gap: 1.7rem; padding: .95rem .95rem  .95rem 1.25rem; color: #0c140d; background: var(--lime); box-shadow: 0 10px 35px rgba(161, 224, 46, .2); }
.primary-action b { width: 28px; height: 28px; display: grid; place-items: center; color: var(--lime); background: #152816; border-radius: 50%; font-size: 1.1rem; }
.secondary-action { padding: 0 0 .28rem; color: var(--ink); border: 0; border-bottom: 1px solid rgba(234,240,223,.4); background: transparent; cursor: pointer; font-family: inherit; }
.primary-action:hover, .secondary-action:hover { transform: translateY(-3px); }

/* ===== Telemetría ===== */
.telemetry {
  list-style: none;
  margin: 2.5rem 0 0;
  padding: 1rem 1.1rem;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1px;
  background: rgba(234, 240, 223, .08);
  border: 1px solid rgba(234, 240, 223, .08);
  max-width: 450px;
}
.telemetry li { background: #07100e; padding: .35rem .1rem; display: flex; flex-direction: column; gap: .25rem; }
.telemetry-label { color: var(--muted); font: 500 .55rem/1 'DM Mono', monospace; letter-spacing: .12em; text-transform: uppercase; }
.telemetry-value { color: var(--ink); font: 700 1.1rem/1 'Manrope', sans-serif; letter-spacing: -.04em; }
.telemetry-value em { color: var(--muted); font-style: normal; font-weight: 500; font-size: .65rem; margin-left: 2px; letter-spacing: .05em; }

.incident-visual { position: relative; min-height: 505px; width: min(100%, 580px); justify-self: center; }
.solar-glow { position: absolute; width: 330px; height: 330px; left: 50%; top: 50%; border-radius: 50%; transform: translate(-50%, -50%); background: radial-gradient(circle, rgba(212,255,69,.21) 0, rgba(212,255,69,.07) 32%, transparent 68%); filter: blur(3px); animation: breathe 4.5s ease-in-out infinite; }
.signal-rings { position: absolute; width: 330px; height: 330px; left: 50%; top: 50%; transform: translate(-50%, -50%); border: 1px solid rgba(212,255,69,.17); border-radius: 50%; animation: rotate 18s linear infinite; }
.signal-rings::before, .signal-rings i { content: ''; position: absolute; inset: 12%; border: 1px dashed rgba(212,255,69,.18); border-radius: 50%; }
.signal-rings i:nth-child(1) { inset: 25%; }.signal-rings i:nth-child(2) { inset: 40%; }.signal-rings i:nth-child(3) { inset: -10%; border-color: rgba(255,121,81,.12); border-style: solid; }
.power-lines { position: absolute; inset: 0; width: 100%; height: 100%; overflow: visible; z-index: 1; }
.line { stroke: rgba(156, 189, 124, .25); stroke-width: 1.2; }.line-back { stroke-width: .8; opacity: .6; }.line-current { stroke: var(--lime); stroke-width: 2.2; stroke-linecap: round; stroke-dasharray: 25 420; filter: drop-shadow(0 0 5px rgba(212,255,69,.9)); }
.current-one { animation: current 2.7s linear infinite; }.current-two { animation: current 3.6s linear infinite reverse; }

/* ===== PANEL SOLAR (montado en la torre, bajo la nube) ===== */
.solar-panel {
  position: absolute;
  top: 30px;
  left: 50%;
  transform: translateX(-50%) rotate(-8deg);
  width: 168px;
  height: 78px;
  z-index: 4;
  pointer-events: none;
  filter: drop-shadow(0 6px 14px rgba(0, 0, 0, .55));
  transition: filter .25s ease, transform .25s ease;
}
.solar-panel--shaded { filter: drop-shadow(0 6px 18px rgba(255, 121, 81, .25)) brightness(.55); }
.solar-panel--shaded .sp-glow { opacity: 0; }

.sp-frame {
  position: absolute;
  inset: 0;
  border: 2.5px solid #b6c8ad;
  background: #0a1410;
  border-radius: 2px;
}
.sp-frame::after {
  content: '';
  position: absolute;
  inset: 0;
  border: 1px solid rgba(0, 0, 0, .6);
  border-radius: 1px;
  margin: 1px;
}

.sp-cells {
  position: absolute;
  inset: 5px;
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  grid-template-rows: repeat(4, 1fr);
  gap: 1px;
  background: #0a0f08;
  padding: 1px;
  border-radius: 1px;
}
.sp-cell {
  display: block;
  background: linear-gradient(135deg, rgba(30, 58, 138, .85) 0%, rgba(15, 35, 75, .9) 100%);
  transition: background .4s ease, box-shadow .4s ease;
  box-shadow: inset 0 0 0 1px rgba(120, 160, 200, .15);
}
.solar-panel--shaded .sp-cell {
  background: linear-gradient(135deg, rgba(15, 23, 42, .9) 0%, rgba(8, 12, 20, .95) 100%);
  box-shadow: inset 0 0 0 1px rgba(80, 100, 130, .12);
}

.sp-glow {
  position: absolute;
  inset: 5px;
  background: linear-gradient(120deg, transparent 30%, rgba(212, 255, 69, .12) 50%, transparent 70%);
  pointer-events: none;
  opacity: 1;
  transition: opacity .25s ease;
}

.sp-cable {
  position: absolute;
  left: 50%;
  bottom: -38px;
  width: 2px;
  height: 40px;
  background: linear-gradient(180deg, #b6c8ad 0%, rgba(182, 200, 173, .4) 100%);
  transform: translateX(-50%);
}

.sp-id {
  position: absolute;
  top: -14px;
  right: 4px;
  font: 500 .45rem/1 'DM Mono', monospace;
  letter-spacing: .12em;
  color: var(--muted);
  opacity: .65;
}

/* ===== NUBE + LLUVIA + RAYO ===== */
.cloud-wrap {
  position: absolute;
  top: 1%;
  left: 50%;
  transform: translate(calc(-50% + (var(--mx, 0) * 1px)), calc(var(--my, 0) * 1px));
  width: 280px;
  height: 240px;
  z-index: 3;
  pointer-events: none;
}

.cloud {
  position: relative;
  width: 100%;
  height: 75px;
  animation: cloudDrift 9s ease-in-out infinite;
  filter: drop-shadow(0 8px 18px rgba(0, 0, 0, .55));
}

.cs {
  position: absolute;
  background: radial-gradient(circle at 35% 30%, var(--cloud-light) 0%, var(--cloud-base) 55%, var(--cloud-shadow) 100%);
  border-radius: 50%;
  transition: filter .15s ease, background .3s ease;
}

.cs-1 { width: 75px;  height: 50px; left: 8px;   top: 22px; }
.cs-2 { width: 90px;  height: 62px; left: 52px;  top: 12px; }
.cs-3 { width: 80px;  height: 58px; left: 118px; top: 4px;  }
.cs-4 { width: 95px;  height: 65px; left: 168px; top: 8px;  }
.cs-5 { width: 70px;  height: 50px; left: 200px; top: 22px; }
.cs-6 { width: 45px;  height: 38px; left: 240px; top: 32px; }
.cs-7 { width: 55px;  height: 42px; left: 32px;  top: 30px; }

.cs-highlight {
  position: absolute;
  inset: 0;
  border-radius: 50%;
  background: radial-gradient(ellipse 60% 35% at 50% 20%, rgba(255, 255, 255, .18), transparent 70%);
  pointer-events: none;
}

.cloud--lit .cs { background: radial-gradient(circle at 35% 30%, #5a6478 0%, #2c3548 55%, #161c2a 100%); }
.cloud--lit .cs-highlight { background: radial-gradient(ellipse 60% 35% at 50% 20%, rgba(212, 255, 69, .35), transparent 70%); }

/* Lluvia */
.rain {
  position: absolute;
  top: 70px;
  left: 0;
  right: 0;
  height: 170px;
  pointer-events: none;
  overflow: hidden;
}
.drop {
  position: absolute;
  top: -20px;
  width: 1px;
  height: 14px;
  background: linear-gradient(180deg, transparent 0%, rgba(200, 215, 195, .7) 50%, rgba(200, 215, 195, .9) 100%);
  animation: rain linear infinite;
  will-change: transform, opacity;
}

@keyframes rain {
  0%   { transform: translate3d(0, 0, 0);    opacity: 0; }
  10%  { opacity: 1; }
  85%  { opacity: 1; }
  100% { transform: translate3d(-2px, 180px, 0); opacity: 0; }
}

@keyframes cloudDrift {
  0%, 100% { transform: translate(0, 0); }
  50%      { transform: translate(8px, -3px); }
}

/* Rayo */
.lightning {
  position: absolute;
  top: 65px;
  left: 50%;
  transform: translateX(-50%);
  width: 70px;
  height: 175px;
  pointer-events: none;
  z-index: 2;
  opacity: 0;
  transition: opacity .05s linear;
}
.lightning--on { opacity: 1; }

/* Sombra de la nube en el suelo */
.ground-shadow {
  position: absolute;
  bottom: 18px;
  left: 50%;
  transform: translateX(-50%);
  width: 240px;
  height: 22px;
  background: radial-gradient(ellipse at center, rgba(0, 0, 0, .55), transparent 70%);
  filter: blur(6px);
  pointer-events: none;
  z-index: 1;
  transition: transform .15s ease, opacity .15s ease;
  animation: shadowPulse 4.5s ease-in-out infinite;
}
.ground-shadow--pulse { transform: translateX(-50%) scale(1.12); opacity: 1; }

@keyframes shadowPulse {
  0%, 100% { transform: translateX(-50%) scale(1); }
  50%      { transform: translateX(-50%) scale(1.06); }
}

/* ===== ANTENA (existente) ===== */
.tower { position: absolute; left: 50%; bottom: 30px; width: 208px; height: 420px; transform: translateX(-50%); filter: drop-shadow(0 0 18px rgba(212,255,69,.12)); z-index: 2; }
.tower-cap { position: absolute; width: 12px; height: 50px; left: calc(50% - 6px); top: 3px; border: 2px solid #b6c8ad; border-bottom: 0; }
.tower-body { position: absolute; left: 50%; top: 47px; width: 1px; height: 372px; background: rgba(202,220,193,.7); }
.tower-leg { position: absolute; height: 380px; top: 0; width: 2px; background: #b6c8ad; transform-origin: top; }.leg-left { transform: rotate(21deg); }.leg-right { transform: rotate(-21deg); }
.cross { position: absolute; display: block; left: 50%; height: 1px; transform: translateX(-50%); background: #b6c8ad; }.cross-top { top: 45px; width: 142px; }.cross-middle { top: 145px; width: 182px; }.cross-bottom { top: 246px; width: 125px; }
.cross::before, .cross::after { content: ''; position: absolute; top: 0; left: 50%; width: 1px; height: 104px; background: rgba(182,200,173,.75); transform-origin: top; }.cross::before { transform: rotate(47deg); }.cross::after { transform: rotate(-47deg); }
.insulators { position: absolute; width: 190px; left: 9px; display: flex; justify-content: space-between; }.insulators-top { top: 79px; }.insulators-bottom { top: 179px; }.insulators i { width: 5px; height: 26px; border-radius: 0 0 5px 5px; background: repeating-linear-gradient(180deg, #d4ff45 0 3px, #657954 3px 6px); box-shadow: 0 0 7px rgba(212,255,69,.35); }

/* ===== FAULT CARD ===== */
.fault-card { position: absolute; z-index: 4; top: 31%; right: -4%; width: 174px; padding: .8rem .9rem .75rem; background: rgba(8, 19, 13, .86); border: 1px solid rgba(212,255,69,.4); box-shadow: 0 15px 45px rgba(0,0,0,.35), inset 0 0 25px rgba(212,255,69,.04); backdrop-filter: blur(8px); transform: rotate(4deg); animation: panelShake 5s ease-in-out infinite; }
.fault-card--storm { border-color: rgba(255, 121, 81, .7); box-shadow: 0 15px 45px rgba(255, 121, 81, .25), inset 0 0 35px rgba(255,121,81,.1); animation: panelShakeStorm .25s ease-in-out infinite; }
.fault-status { display: flex; align-items: center; gap: .4rem; color: var(--orange); font: 500 .47rem 'DM Mono', monospace; letter-spacing: .08em; }.fault-status span { width: 5px; height: 5px; border-radius: 50%; background: currentColor; }
.fault-card strong { display: block; margin: .35rem 0 0; color: var(--ink); font: 800 3.65rem/.9 'Manrope', sans-serif; letter-spacing: -.08em; }.fault-card p { margin: .3rem 0 .7rem; color: var(--muted); font: 500 .5rem 'DM Mono', monospace; letter-spacing: .1em; }
.fault-meter { display: flex; gap: 3px; }.fault-meter i { display: block; height: 4px; flex: 1; background: rgba(212,255,69,.2); transition: background .15s ease; }
.fault-meter i:nth-child(-n+3) { background: var(--orange); animation: meterBlink 1.1s steps(2) infinite; }
.fault-meter--storm i:nth-child(-n+5) { background: var(--orange); animation: meterBlinkFast .35s steps(2) infinite; }

.spark { position: absolute; z-index: 3; color: var(--lime); text-shadow: 0 0 13px var(--lime); font-size: 1.1rem; animation: spark 2.2s ease-in-out infinite; }.spark-one { left: 25%; top: 30%; }.spark-two { right: 19%; bottom: 25%; font-size: .75rem; animation-delay: -.8s; }.spark-three { left: 16%; bottom: 20%; color: var(--orange); animation-delay: -1.3s; }

.outage-footer { padding-top: 1rem; border-top: 1px solid rgba(211, 235, 194, .13); }.outage-footer b { color: var(--orange); font-weight: 500; }

@keyframes scan { to { transform: translateY(900%); } }
@keyframes blink { 50% { opacity: .25; } }
@keyframes alertPulse { 70% { box-shadow: 0 0 0 9px rgba(255,121,81,0); } 100% { box-shadow: 0 0 0 0 rgba(255,121,81,0); } }
@keyframes breathe { 50% { transform: translate(-50%, -50%) scale(1.12); opacity: .7; } }
@keyframes rotate { to { transform: translate(-50%, -50%) rotate(360deg); } }
@keyframes current { to { stroke-dashoffset: -445; } }
@keyframes panelShake { 0%, 88%, 100% { transform: rotate(4deg) translate(0); } 90% { transform: rotate(4deg) translate(2px, -1px); } 92% { transform: rotate(4deg) translate(-3px, 1px); } 94% { transform: rotate(4deg) translate(1px); } }
@keyframes panelShakeStorm { 0%, 100% { transform: rotate(4deg) translate(0, 0); } 25% { transform: rotate(4deg) translate(2px, -2px); } 50% { transform: rotate(4deg) translate(-2px, 2px); } 75% { transform: rotate(4deg) translate(2px, 1px); } }
@keyframes meterBlink { 50% { opacity: .28; } }
@keyframes meterBlinkFast { 50% { opacity: .15; } }
@keyframes spark { 0%,100% { transform: scale(.5) rotate(0deg); opacity: .2; } 45% { transform: scale(1.25) rotate(25deg); opacity: 1; } }

@media (max-width: 850px) {
  .outage-content { grid-template-columns: 1fr; gap: .5rem; padding: 3rem 0 1.5rem; }
  .incident-copy { text-align: center; padding-top: 0; }
  .eyebrow, .actions { justify-content: center; }
  .description { margin-left: auto; margin-right: auto; }
  .telemetry { margin-left: auto; margin-right: auto; }
  .incident-visual { min-height: 370px; width: 440px; max-width: 100%; }
  .tower { transform: translateX(-50%) scale(.82); transform-origin: bottom center; }
  .cloud-wrap { transform: translate(-50%, 0) scale(.75); transform-origin: top center; }
  .ground-shadow { transform: translateX(-50%) scale(.7); }
  .fault-card { right: 1%; top: 24%; transform: scale(.84) rotate(4deg); }
  .signal-rings { transform: translate(-50%, -50%) scale(.82); }
  .solar-glow { transform: translate(-50%, -50%) scale(.82); }
}
@media (max-width: 500px) {
  .outage-page { padding: 1.3rem 1.1rem 1rem; }
  .location { font-size: .52rem; }
  .location span { display: none; }
  h1 { font-size: clamp(2.8rem, 15vw, 4rem); }
  .actions { gap: .9rem; }
  .primary-action { width: 100%; justify-content: space-between; }
  .telemetry { grid-template-columns: repeat(3, 1fr); padding: .7rem; }
  .telemetry-value { font-size: .9rem; }
  .incident-visual { min-height: 315px; }
  .tower { bottom: 0; transform: translateX(-50%) scale(.68); }
  .cloud-wrap { transform: translate(-50%, 0) scale(.55); }
  .ground-shadow { transform: translateX(-50%) scale(.5); }
  .fault-card { right: -4%; top: 22%; transform: scale(.68) rotate(4deg); }
  .signal-rings { transform: translate(-50%, -50%) scale(.68); }
  .solar-glow { transform: translate(-50%, -50%) scale(.7); }
  .outage-footer { font-size: .48rem; letter-spacing: .07em; }
  .outage-footer span:first-child { max-width: 180px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation-duration: .01ms !important; animation-iteration-count: 1 !important; scroll-behavior: auto !important; }
}
</style>
