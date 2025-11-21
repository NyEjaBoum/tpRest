<template>
  <div class="bg-white p-4 rounded shadow">
    <h2 class="font-semibold mb-2">Semestres</h2>
    <ul class="space-y-2">
      <li v-for="s in semesters" :key="s.id" class="flex items-center justify-between">
        <div>{{ s.name }}</div>
        <button class="text-blue-600" @click="$emit('open-semester', s.id)">Voir étudiants</button>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'SemestersList',
  data() {
    return {
      semesters: [
        { id: 1, name: 'Semestre 1' },
        { id: 2, name: 'Semestre 2' },
        { id: 3, name: 'Semestre 3' },
        { id: 4, name: 'Semestre 4' },
      ]
    }
  }
}
</script>

<style scoped>
</style>
