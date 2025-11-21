<template>
  <div class="bg-white p-4 rounded shadow">
    <div class="flex justify-between items-center mb-3">
      <h2 class="font-semibold">Détails Étudiant</h2>
      <button class="text-sm text-gray-600" @click="$emit('back')">Retour</button>
    </div>

    <div v-if="student">
      <p><strong>Nom:</strong> {{ student?.nom }}</p>
      <p><strong>Option:</strong> {{ student?.option }}</p>

      <h3 class="mt-4 font-medium">Moyennes</h3>
      <table class="mt-2">
        <thead>
          <tr><th>S1</th><th>S2</th><th>S3</th><th>S4</th><th>Actions</th></tr>
        </thead>
        <tbody>
          <tr>
            <td class="px-2">{{ student.moyennes.s1 }}</td>
            <td class="px-2">{{ student.moyennes.s2 }}</td>
            <td class="px-2">{{ student.moyennes.s3 }}</td>
            <td class="px-2">{{ student.moyennes.s4 }}</td>
            <td class="px-2">
              <a class="text-blue-600 mr-2 cursor-pointer" @click="$emit('show-grade', { studentId: student.id, period: 'L1' })">L1 (S1+S2)</a>
              <a class="text-blue-600 cursor-pointer" @click="$emit('show-grade', { studentId: student.id, period: 'L2' })">L2 (S3+S4)</a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else>
      <p>Aucun étudiant sélectionné.</p>
    </div>
  </div>
</template>

<script>
import { getStudentById } from '../data/mockData.js'

export default {
  name: 'StudentDetail',
  props: { studentId: { type: [String, Number], required: false } },
  computed: {
    student() {
      if (!this.studentId) return null
      return getStudentById(this.studentId)
    }
  }
}
</script>

<style scoped>
table { border-collapse: collapse; }
th, td { padding: 6px 8px; border-bottom: 1px solid #eee }
</style>
