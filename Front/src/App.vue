<template>
  <div class="p-6">
    <h1 class="text-2xl font-bold mb-4">Gestion Semestres / Étudiants (Frontend demo)</h1>
    <nav class="mb-4">
      <router-link to="/semesters" class="text-blue-600">Semestres</router-link>
    </nav>
    <router-view />
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({ name: 'App' })
</script>

<style scoped>
.table { width: 100%; }
</style>
