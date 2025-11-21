<template>
  <div class="bg-white p-4 rounded shadow">
    <div class="flex justify-between items-center mb-3">
      <h2 class="font-semibold">Relevé de notes - {{ periodLabel }}</h2>
      <button class="text-sm text-gray-600" @click="$emit('back')">Retour</button>
    </div>

    <div v-if="student">
      <p><strong>Étudiant:</strong> {{ student.nom }} ({{ student.option }})</p>

      <table class="mt-3">
        <thead>
          <tr><th>UE</th><th>Note</th></tr>
        </thead>
        <tbody>
          <tr v-for="(note, idx) in notes" :key="idx">
            <td class="px-2">{{ note.ue }}</td>
            <td class="px-2">{{ note.note }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import { getStudentById } from '../data/mockData.js'

export default {
  name: 'GradeReport',
  props: { studentId: { type: [String, Number] }, period: { type: String } },
  computed: {
    periodLabel() {
      return this.period || 'S1'
    },
    student() {
      if (!this.studentId) return null
      return getStudentById(this.studentId)
    },
    notes() {
      const base = [
        { ue: 'UE1', note: 12 },
        { ue: 'UE2', note: 14 },
        { ue: 'UE3', note: 13 }
      ]
      if (this.period === 'S1') return base
      if (this.period === 'S2') return base.map(n => ({ ...n, note: n.note + 1 }))
      if (this.period === 'S3') return base.map(n => ({ ...n, note: n.note + 2 }))
      if (this.period === 'S4') return base.map(n => ({ ...n, note: n.note + 1.5 }))
      if (this.period === 'L1') return base.concat([{ ue: 'UE4', note: 15 }])
      if (this.period === 'L2') return base.concat([{ ue: 'UE4', note: 14.5 }])
      return base
    }
  }
}
</script>

<style scoped>
table { width: 100%; border-collapse: collapse; }
th, td { padding: 6px 8px; border-bottom: 1px solid #eee }
</style>
