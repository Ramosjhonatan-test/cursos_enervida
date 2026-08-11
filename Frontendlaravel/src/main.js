import { createApp } from 'vue'
import { createPinia } from 'pinia'
import GoogleSignInPlugin from 'vue3-google-signin'
import App from './App.vue'
import router from './router'
import './assets/main.css'
import { useAuthStore } from '@/stores/auth'

const app = createApp(App)
const pinia = createPinia()

app.use(pinia)
app.use(router)
app.use(GoogleSignInPlugin, {
  clientId: '1034857094061-ia2g82gh7hqvp4mkdc6e50hqgu0qv04k.apps.googleusercontent.com',
})

const authStore = useAuthStore(pinia)
authStore.initAuth()

app.mount('#app')
