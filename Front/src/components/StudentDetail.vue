<template>
  <div class="bg-white p-4 rounded shadow">
    <div class="flex justify-between items-center mb-3">
      <h2 class="font-semibold">Détails Étudiant</h2>
      <button class="text-sm text-gray-600" @click="$emit('back')">Retour</button>
    </div>

    <div v-if="etudiant">
      <p><strong>Nom:</strong> {{ etudiant?.nom }}</p>
      <p><strong>Option:</strong> {{ etudiant?.semestre?.libelle || 'N/A' }}</p>

      <h3 class="mt-4 font-medium">Moyennes</h3>
      <div v-if="loading">Chargement...</div>
      <div v-else-if="error" class="text-red-600">{{ error }}</div>
      <table class="mt-2">
        <thead>
          <tr><th>S1</th><th>S2</th><th>S3</th><th>S4</th><th>Actions</th></tr>
        </thead>
        <tbody>
          <tr>
            <td class="px-2">{{ formatMoy(moyennes?.S1) }}</td>
            <td class="px-2">{{ formatMoy(moyennes?.S2) }}</td>
            <td class="px-2">{{ formatMoy(moyennes?.S3) }}</td>
            <td class="px-2">{{ formatMoy(moyennes?.S4) }}</td>
            <td class="px-2">
              <a class="text-blue-600 mr-2 cursor-pointer" @click="$emit('show-grade', { studentId: etudiant.idEtudiant, period: 'L1' })">L1 (S1+S2)</a>
              <a class="text-blue-600 cursor-pointer" @click="$emit('show-grade', { studentId: etudiant.idEtudiant, period: 'L2' })">L2 (S3+S4)</a>
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
export default {
  name: 'StudentDetail',
  props: { studentId: { type: [String, Number], required: false } },
  data() {
    return {
      etudiant: null,
      moyennes: null,
      loading: false,
      error: null
    }
  },
  watch: {
    studentId: {
      immediate: true,
      handler(newId) {
        this.fetchInfos(newId)
      }
    }
  },
  methods: {
    async fetchInfos(id) {
      if (!id) return
      this.loading = true
      this.error = null
      try {
        const base = import.meta.env.VITE_API_BASE_URL || ''
        const res = await fetch(`${base}/etudiants/${id}/infos-moyennes`)
        const json = await res.json()
        if (json.status === 'success') {
          this.etudiant = json.data?.etudiant || null
          this.moyennes = json.data?.moyennes || {}
        } else {
          this.error = json.error?.message || 'Erreur API'
          this.etudiant = null
          this.moyennes = {}
        }
      } catch (e) {
        this.error = e.message
        this.etudiant = null
        this.moyennes = {}
      } finally {
        this.loading = false
      }
    }
    ,
    formatMoy(v) {
      if (v === null || v === undefined) return '-'
      const n = Number(v)
      if (Number.isNaN(n)) return String(v)
      return Math.round(n * 100) / 100
    }
  }
}
</script>
<style scoped>
table { border-collapse: collapse; }
th, td { padding: 6px 8px; border-bottom: 1px solid #eee }
</style>
