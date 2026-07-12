import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    allowedHosts: ["shortify.lnks.website", "www.shortify.lnks.website",
      "lnks.website", "lnks.website"]
  }
})
