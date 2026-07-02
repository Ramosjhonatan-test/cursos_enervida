/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  darkMode: "class",
  theme: {
    extend: {
      "colors": {
              "primary": "var(--primary)",
              "accent-neon": "var(--accent-neon)",
              "accent-solar": "var(--accent-solar)",
              "surface-glass": "var(--surface-glass)",
              "on-surface": "var(--on-surface)",
              "on-surface-variant": "var(--on-surface-variant)",
              "background": "var(--background)",
              "input-bg": "var(--input-bg)",
              "input-border": "var(--input-border)",
              "surface-container": "var(--surface-container)",
              "surface-card": "var(--surface-card)",
              
              // Compatibilidad con Paneles
              "primary-container": "var(--primary-container)",
              "secondary-container": "var(--secondary-container)",
              "tertiary-container": "var(--tertiary-container)",
              "on-primary-container": "var(--on-primary-container)",
              "on-secondary-container": "var(--on-secondary-container)",
              "on-tertiary-container": "var(--on-tertiary-container)",
              "on-background": "var(--on-background)",
      },
      "borderRadius": {
              "premium": "48px",
              "organic-1": "80px 30px 80px 30px",
              "organic-2": "30px 80px 30px 80px"
      },
      "fontFamily": {
              "lexend": ["Lexend", "sans-serif"],
              "inter": ["Inter", "sans-serif"],
              // Alias para paneles
              "h1": ["Lexend", "sans-serif"],
              "h2": ["Lexend", "sans-serif"],
              "h3": ["Lexend", "sans-serif"],
              "body-md": ["Inter", "sans-serif"],
              "label-sm": ["Inter", "sans-serif"],
      }
    },
  },
  plugins: [],
}
