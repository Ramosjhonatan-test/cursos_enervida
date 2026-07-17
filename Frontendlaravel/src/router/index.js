import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/public/Inicio.vue'
import LoginView from '../views/auth/Acceso.vue'
import RegisterView from '../views/auth/Registro.vue'
import AdminLayout from '../views/admin/AdminLayout.vue'
import EstudianteLayout from '../views/estudiante/EstudianteLayout.vue'
import { useAuthStore } from '@/stores/auth'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/cursos/vivenciales',
      name: 'cursos-vivenciales',
      component: () => import('../views/public/CursosVivenciales.vue')
    },
    {
      path: '/cursos/online',
      name: 'cursos-online',
      component: () => import('../views/public/CursosOnline.vue')
    },
    {
      path: '/cursos/tecnicos',
      name: 'cursos-tecnicos',
      component: () => import('../views/public/CursosTecnicos.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
      meta: { guest: true }
    },
    {
      path: '/register',
      name: 'register',
      component: RegisterView,
      meta: { guest: true }
    },
    {
      path: '/admin',
      component: AdminLayout,
      meta: { requiresAuth: true, requiresAdmin: true }, // Acceso base administrativo
      children: [
        {
          path: '',
          name: 'admin-dashboard',
          component: () => import('../views/admin/AdminDashboard.vue'),
          meta: { moduleId: 'DASHBOARD' }
        },
        {
          path: 'solicitudes',
          name: 'admin-solicitudes',
          component: () => import('../views/admin/AdminSolicitudes.vue'),
          meta: { moduleId: 'SOLICITUDES' }
        },
        {
          path: 'cursos',
          name: 'admin-cursos',
          component: () => import('../views/admin/AdminCursos.vue'),
          meta: { moduleId: 'CURSOS' }
        },
        {
          path: 'cursos/nuevo',
          name: 'admin-curso-nuevo',
          component: () => import('../views/admin/AdminCursoForm.vue'),
          meta: { moduleId: 'CURSOS' }
        },
        {
          path: 'cursos/editar/:id',
          name: 'admin-curso-editar',
          component: () => import('../views/admin/AdminCursoForm.vue'),
          props: true,
          meta: { moduleId: 'CURSOS' }
        },
        {
          path: 'cursos/:id',
          name: 'admin-curso-detalle',
          component: () => import('../views/admin/AdminCursoDetalle.vue'),
          props: true,
          meta: { moduleId: 'CURSOS' }
        },
        {
          path: 'estudiantes',
          name: 'admin-estudiantes',
          component: () => import('../views/admin/AdminEstudiantes.vue'),
          meta: { moduleId: 'ESTUDIANTES' }
        },
        {
          path: 'estudiantes/nuevo',
          name: 'admin-estudiante-nuevo',
          component: () => import('../views/admin/AdminEstudianteForm.vue'),
          meta: { moduleId: 'ESTUDIANTES' }
        },
        {
          path: 'estudiantes/editar/:id',
          name: 'admin-estudiante-editar',
          component: () => import('../views/admin/AdminEstudianteForm.vue'),
          props: true,
          meta: { moduleId: 'ESTUDIANTES' }
        },
        {
          path: 'estudiantes/:id',
          name: 'admin-estudiante-detalle',
          component: () => import('../views/admin/AdminEstudianteDetalle.vue'),
          props: true,
          meta: { moduleId: 'ESTUDIANTES' }
        },
        {
          path: 'calificaciones',
          name: 'admin-calificaciones',
          component: () => import('../views/admin/AdminCalificaciones.vue'),
          meta: { moduleId: 'EVALUACIONES' }
        },
        {
          path: 'evaluaciones',
          name: 'admin-evaluaciones',
          component: () => import('../views/admin/AdminEvaluaciones.vue'),
          meta: { moduleId: 'EVALUACIONES' }
        },
        {
          path: 'evaluaciones/:id/preguntas',
          name: 'admin-preguntas',
          component: () => import('../views/admin/AdminPreguntas.vue'),
          props: true,
          meta: { moduleId: 'EVALUACIONES' }
        },
        {
          path: 'reportes',
          name: 'admin-reportes',
          component: () => import('../views/admin/AdminReportes.vue'),
          meta: { moduleId: 'REPORTES' }
        },
        {
          path: 'auditoria',
          name: 'admin-auditoria',
          component: () => import('../views/admin/AdminAuditoria.vue'),
          meta: { moduleId: 'AUDITORIA' }
        },
        {
          path: 'clases-en-vivo',
          name: 'admin-clases-en-vivo',
          component: () => import('../views/admin/AdminClasesVivo.vue'),
          meta: { moduleId: 'CLASES_VIVO' }
        },
        {
          path: 'usuarios',
          name: 'admin-usuarios',
          component: () => import('../views/admin/AdminUsuarios.vue'),
          meta: { moduleId: 'USUARIOS' }
        },
        {
          path: 'categorias',
          name: 'admin-categorias',
          component: () => import('../views/admin/AdminCategorias.vue'),
          meta: { moduleId: 'CATEGORIAS' }
        },
        {
          path: 'roles',
          name: 'admin-roles',
          component: () => import('../views/admin/AdminRoles.vue'),
          meta: { moduleId: 'ROLES' }
        },
        {
          path: 'inscripciones',
          name: 'admin-inscripciones',
          component: () => import('../views/admin/AdminInscripciones.vue'),
          meta: { moduleId: 'INSCRIPCIONES' }
        },
        {
          path: 'notificaciones',
          name: 'admin-notificaciones',
          component: () => import('../views/admin/AdminNotificaciones.vue'),
          meta: { moduleId: 'NOTIFICACIONES' }
        },
        {
          path: 'dispositivos',
          name: 'admin-dispositivos',
          component: () => import('../views/admin/AdminDispositivos.vue'),
          meta: { moduleId: 'DISPOSITIVOS' }
        },
        {
          path: 'certificados',
          name: 'admin-certificados',
          component: () => import('../views/admin/AdminCertificados.vue'),
          meta: { moduleId: 'CERTIFICADOS' }
        },
        {
          path: 'certificados/diseno/:cursoId',
          name: 'admin-certificado-editor',
          component: () => import('../views/admin/AdminCertificadoEditor.vue'),
          props: true,
          meta: { moduleId: 'CERTIFICADOS' }
        },
        {
          path: 'archivos',
          name: 'admin-archivos',
          component: () => import('../views/admin/AdminArchivos.vue'),
          meta: { moduleId: 'ARCHIVOS' }
        },
        {
          path: 'verificacion-qr',
          name: 'admin-verificacion-qr',
          component: () => import('../views/admin/AdminVerificacionQr.vue'),
          meta: { moduleId: 'CERTIFICADOS' }
        }
      ]
    },
    {
      path: '/student',
      component: EstudianteLayout,
      meta: { requiresAuth: true, role: 'estudiante' }, // Student
      children: [
        {
          path: '',
          redirect: '/student/dashboard'
        },
        {
          path: 'dashboard',
          name: 'student-dashboard',
          component: () => import('../views/estudiante/EstudianteEscritorio.vue')
        },
        {
          path: 'catalog',
          name: 'student-catalog',
          component: () => import('../views/estudiante/EstudianteCatalogo.vue')
        },
        {
          path: 'my-courses',
          name: 'student-my-courses',
          component: () => import('../views/estudiante/EstudianteMisCursos.vue')
        },
        {
          path: 'labs',
          name: 'student-labs',
          component: () => import('../views/estudiante/EstudianteLaboratorios.vue')
        },
        {
          path: 'certificates',
          name: 'student-certificates',
          component: () => import('../views/estudiante/EstudianteCertificados.vue')
        },
        {
          path: 'live-classes',
          name: 'student-live-classes',
          component: () => import('../views/estudiante/EstudianteClasesVivo.vue')
        },
        {
          path: 'profile',
          name: 'student-profile',
          component: () => import('../views/estudiante/EstudiantePerfil.vue')
        },
        {
          path: 'support',
          name: 'student-support',
          component: () => import('../views/estudiante/EstudianteSoporte.vue')
        }
      ]
    },
    {
      path: '/student/course/:id',
      name: 'course-player',
      component: () => import('../views/estudiante/ReproductorCurso.vue'),
      meta: { requiresAuth: true, role: 'estudiante' },
      props: true
    },
    {
      path: '/student/exam/:id',
      name: 'exam-player',
      component: () => import('../views/estudiante/Evaluacion.vue'),
      meta: { requiresAuth: true, role: 'estudiante' },
      props: true
    },
    {
      path: '/verificar/:codigo?',
      name: 'verificar-certificado',
      component: () => import('../views/public/VerificarCertificadoAntiguos.vue')
    },
    {
      path: '/forgot-password',
      name: 'forgot-password',
      component: () => import('../views/auth/RecuperarPassword.vue'),
      meta: { guest: true }
    },
    {
      path: '/reset-password',
      name: 'reset-password',
      component: () => import('../views/auth/RestablecerPassword.vue'),
      meta: { guest: true }
    },
    {
      path: '/verify-email',
      name: 'verify-email',
      component: () => import('../views/auth/VerificarEmail.vue'),
      meta: { guest: true }
    }
  ]
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()
  const isAuthenticated = authStore.isAuthenticated
  const user = authStore.user
  const userRole = user?.rol?.nombre?.toLowerCase()

  // 1. Manejo de rutas que requieren autenticación
  if (to.meta.requiresAuth) {
    if (!isAuthenticated) {
      return next('/login');
    }

    // Si requiere rol específico (ej: estudiante)
    if (to.meta.role && userRole !== to.meta.role.toLowerCase()) {
      // Si el usuario no tiene el rol requerido, lo mandamos a su área correspondiente
      const target = userRole === 'estudiante' ? '/student' : '/admin';
      return next(target);
    }

    // 2. Control de acceso granular para rutas administrativas
    const isUnderAdmin = to.matched.some(record => record.path.startsWith('/admin'));
    if (isUnderAdmin) {
      if (userRole !== 'admin') {
        // Obtenemos el moduleId de la ruta actual o de sus padres
        const moduleId = to.meta.moduleId || to.matched.find(r => r.meta.moduleId)?.meta.moduleId;
        
        if (moduleId && !authStore.canAccess(moduleId)) {
          console.warn(`Acceso denegado al módulo: ${moduleId}`);
          
          // EVITAR BUCLE: Si ya estamos en la app y no tenemos permiso, no navegar.
          // Si venimos de login o fuera, permitimos entrar al layout de admin
          // y que el AdminLayout decida a donde mandarlo.
          if (from.path && from.path !== '/' && from.path !== '/login') {
            return next(false);
          } else {
            if (to.path !== '/admin') {
              return next('/admin');
            } else {
              return next();
            }
          }
        }
      }
    }
  }

  // 3. Redirección de usuarios autenticados que intentan entrar a login/register (guest routes)
  if (to.meta.guest && isAuthenticated) {
    // Si es estudiante va a /student, cualquier otro rol (admin, profesor, etc.) va a /admin
    const target = userRole === 'estudiante' ? '/student' : '/admin';
    return next(target);
  }

  next();
});

export default router
