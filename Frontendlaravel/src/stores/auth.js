import { defineStore } from 'pinia';
import api from '@/services/api';
import { getDeviceInfo } from '@/services/device';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')) || null,
    accessToken: localStorage.getItem('access_token') || null,
    refreshToken: localStorage.getItem('refresh_token') || null,
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
          return data.permisos?.includes(moduloId);
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

        this.accessToken = access_token;
        this.refreshToken = refresh_token;
        this.user = user;

        localStorage.setItem('access_token', access_token);
        localStorage.setItem('refresh_token', refresh_token);
        localStorage.setItem('user', JSON.stringify(user));

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

        this.accessToken = access_token;
        this.refreshToken = refresh_token;
        this.user = user;

        localStorage.setItem('access_token', access_token);
        localStorage.setItem('refresh_token', refresh_token);
        localStorage.setItem('user', JSON.stringify(user));

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
        if (!this.refreshToken || !this.user) return null;

        const response = await api.post('/auth/refresh', {
          userId: this.user.id,
          refreshToken: this.refreshToken,
        });

        const { access_token, refresh_token } = response.data;

        this.accessToken = access_token;
        this.refreshToken = refresh_token;

        localStorage.setItem('access_token', access_token);
        localStorage.setItem('refresh_token', refresh_token);

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
        
        const { access_token, refresh_token, user } = response.data;
        this.accessToken = access_token;
        this.refreshToken = refresh_token;
        this.user = user;

        localStorage.setItem('access_token', access_token);
        localStorage.setItem('refresh_token', refresh_token);
        localStorage.setItem('user', JSON.stringify(user));

        return user;
      } catch (error) {
        throw error;
      }
    },

    setAuth(data) {
      const { access_token, refresh_token, user } = data;
      this.accessToken = access_token;
      this.refreshToken = refresh_token;
      this.user = user;

      localStorage.setItem('access_token', access_token);
      localStorage.setItem('refresh_token', refresh_token);
      localStorage.setItem('user', JSON.stringify(user));
    },

    clearAuth() {
      this.user = null;
      this.accessToken = null;
      this.refreshToken = null;
      localStorage.removeItem('access_token');
      localStorage.removeItem('refresh_token');
      localStorage.removeItem('user');
    },
  },
});
