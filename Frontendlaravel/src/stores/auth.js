import { defineStore } from 'pinia';
import api from '@/services/api';
import { getDeviceInfo } from '@/services/device';

const REFRESH_MARGIN_SECONDS = 60;
const MIN_REFRESH_DELAY_MS = 5000;

function parseJwt(token) {
  if (!token) return null;
  try {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      atob(base64)
        .split('')
        .map((c) => `%${('00' + c.charCodeAt(0).toString(16)).slice(-2)}`)
        .join('')
    );
    return JSON.parse(jsonPayload);
  } catch (error) {
    console.warn('Unable to parse JWT token', error);
    return null;
  }
}

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')) || null,
    accessToken: localStorage.getItem('access_token') || null,
    refreshTimer: null,
  }),

  getters: {
    isAuthenticated: (state) => !!state.accessToken,
    userRole: (state) => state.user?.rol?.nombre || null,
    canAccess: (state) => (moduloId) => {
      if (!state.user || !state.user.rol) return false;
      const roleName = state.user.rol.nombre.toLowerCase();
      
      // Superadmin tiene acceso a todo
      if (roleName === 'admin') return true;
      
      // Intentar parsear los permisos del campo descripcion
      try {
        const desc = state.user.rol.descripcion;
        if (desc && desc.startsWith('{')) {
          const data = JSON.parse(desc);
          const permisos = Array.isArray(data.permisos)
            ? data.permisos.map(p => String(p).toUpperCase().trim())
            : [];
          return permisos.includes(String(moduloId).toUpperCase().trim());
        }
      } catch (e) {
        console.warn('Error parsing permissions for role:', roleName);
      }
      return false;
    }
  },

  actions: {
    async login(credentials) {
      try {
        const deviceInfo = getDeviceInfo();
        const response = await api.post('/auth/login', {
          ...credentials,
          fingerprint: deviceInfo.fingerprint,
          navegador: deviceInfo.browser,
          sistema_operativo: deviceInfo.os
        });
        const { access_token, refresh_token, user } = response.data;

        this.setAuth({ access_token, refresh_token, user });
        return user;
      } catch (error) {
        throw error;
      }
    },

    async register(userData) {
      try {
        const deviceInfo = getDeviceInfo();
        const response = await api.post('/auth/register', {
          ...userData,
          fingerprint: deviceInfo.fingerprint,
          navegador: deviceInfo.browser,
          sistema_operativo: deviceInfo.os
        });
        const { access_token, refresh_token, user } = response.data;

        this.setAuth({ access_token, refresh_token, user });
        return user;
      } catch (error) {
        throw error;
      }
    },

    async logout() {
      try {
        if (this.accessToken) {
          await api.post('/auth/logout');
        }
      } catch (error) {
        console.error('Logout error', error);
      } finally {
        this.clearAuth();
      }
    },

    async refreshAccessToken() {
      try {
        if (!this.user) return null;

        const response = await api.post('/auth/refresh', {
          userId: this.user.id,
        });

        const { access_token } = response.data;

        this.accessToken = access_token;

        localStorage.setItem('access_token', access_token);

        this.scheduleRefresh();
        return access_token;
      } catch (error) {
        this.clearAuth();
        throw error;
      }
    },

    async forgotPassword(email) {
      try {
        const response = await api.post('/auth/forgot-password', { email });
        return response.data;
      } catch (error) {
        throw error;
      }
    },

    async resetPassword(data) {
      try {
        const response = await api.post('/auth/reset-password', data);
        return response.data;
      } catch (error) {
        throw error;
      }
    },

    async verifyEmail(token) {
      try {
        const response = await api.get(`/auth/verify-email?token=${token}`);
        return response.data;
      } catch (error) {
        throw error;
      }
    },

    async updateUser(userData) {
      try {
        const updatedUser = {
          ...this.user,
          ...userData
        };
        if (updatedUser.contrasena) delete updatedUser.contrasena;
        this.user = updatedUser;
        localStorage.setItem('user', JSON.stringify(updatedUser));
        return updatedUser;
      } catch (error) {
        console.error('Error updating user in store:', error);
        throw error;
      }
    },

    async googleLogin(payload) {
      try {
        const deviceInfo = getDeviceInfo();
        const response = await api.post('/auth/google', {
          ...payload,
          fingerprint: deviceInfo.fingerprint,
          navegador: deviceInfo.browser,
          sistema_operativo: deviceInfo.os
        });
        
        const { access_token, user } = response.data;
        this.setAuth({ access_token, user });
        return user;
      } catch (error) {
        throw error;
      }
    },

    setAuth(data) {
      const { access_token, user } = data;
      this.accessToken = access_token;
      this.user = user;

      localStorage.setItem('access_token', access_token);
      localStorage.setItem('user', JSON.stringify(user));
      this.scheduleRefresh();
    },

    initAuth() {
      if (this.accessToken && this.refreshToken && this.user) {
        this.scheduleRefresh();
      }
    },

    clearRefreshTimer() {
      if (this.refreshTimer) {
        clearTimeout(this.refreshTimer);
        this.refreshTimer = null;
      }
    },

    scheduleRefresh() {
      this.clearRefreshTimer();

      if (!this.accessToken) return;
      const payload = parseJwt(this.accessToken);
      if (!payload?.exp) return;

      const expiresAtMs = payload.exp * 1000;
      const refreshAtMs = expiresAtMs - REFRESH_MARGIN_SECONDS * 1000;
      const now = Date.now();
      const delay = Math.max(refreshAtMs - now, MIN_REFRESH_DELAY_MS);

      if (expiresAtMs <= now) {
        this.refreshAccessToken().catch(() => {});
        return;
      }

      this.refreshTimer = setTimeout(async () => {
        try {
          await this.refreshAccessToken();
        } catch (error) {
          console.error('Auto refresh failed:', error);
        }
      }, delay);
    },

    clearAuth() {
      this.clearRefreshTimer();
      this.user = null;
      this.accessToken = null;
      localStorage.removeItem('access_token');
      localStorage.removeItem('user');
    },
  },
});
