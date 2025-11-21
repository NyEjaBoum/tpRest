<template>
  <div class="bg-white p-4 rounded shadow">
    <div class="flex items-center justify-between mb-3">
      <h2 class="font-semibold">Étudiants - Semestre {{ semesterId }}</h2>
    </div>

    <table class="min-w-full text-left">
      <thead>
        <tr>
          <th>Nom</th>
          <th>Option</th>
          <th class="text-center">Moy S1</th>
          <th class="text-center">Moy S2</th>
          <th class="text-center">Moy S3</th>
          <th class="text-center">Moy S4</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="st in students" :key="st.id" class="hover:bg-slate-50 cursor-pointer">
          <td @click="$emit('show-student', st.id)">{{ st.nom }}</td>
          <td>{{ st.option }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S1' })">{{ st.moyennes.s1 }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S2' })">{{ st.moyennes.s2 }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S3' })">{{ st.moyennes.s3 }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S4' })">{{ st.moyennes.s4 }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { students } from '../data/mockData.js'

export default {
  name: 'StudentsList',
  props: { semesterId: { type: Number, required: true } },
  data() {
    return { students }
  }
}
</script>

<style scoped>
table { width: 100%; border-collapse: collapse; }
th, td { padding: 8px 6px; border-bottom: 1px solid #eee }
</style>
