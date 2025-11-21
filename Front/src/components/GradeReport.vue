<template>
  <div class="bg-white p-4 rounded shadow">
    <div class="flex justify-between items-center mb-3">
      <h2 class="font-semibold">Relevé de notes - {{ periodLabel }}</h2>
      <button class="text-sm text-gray-600" @click="$emit('back')">Retour</button>
    </div>

    <div>
      <div v-if="loading">Chargement...</div>
      <div v-else-if="error" class="text-red-600">{{ error }}</div>
      <div v-else>
        <p v-if="student"><strong>Étudiant:</strong> {{ student.nom }} ({{ student.matricule || student.prenom || '' }})</p>

        <table class="mt-3" v-if="notes && notes.length">
          <thead>
            <tr>
              <th>Matière</th>
              <th class="text-center">Semestre</th>
              <th class="text-center">Note</th>
              <th class="text-center">Date</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(n, idx) in notes" :key="idx">
              <td class="px-2">{{ n.matiere || n.ue || n.raw?.matiere?.libelle || '-' }}</td>
              <td class="px-2 text-center">{{ n.semestre || n.raw?.inscription?.semestre?.libelle || '-' }}</td>
              <td class="px-2 text-center">{{ n.note }}</td>
              <td class="px-2 text-center">{{ n.date || n.raw?.dateInsertion || '-' }}</td>
            </tr>
          </tbody>
        </table>

        <div v-else class="text-gray-600">Aucune note pour cette période.</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'GradeReport',
  props: { studentId: { type: [String, Number] }, period: { type: String } },
  data() {
    return {
      student: null,
      notes: [],
      loading: false,
      error: null
    }
  },
  watch: {
    studentId: { immediate: true, handler() { this.loadAll() } },
    period: { immediate: true, handler() { this.loadAll() } }
  },
  methods: {
    async loadAll() {
      if (!this.studentId) return
      this.loading = true
      this.error = null
      try {
        const base = import.meta.env.VITE_API_BASE_URL || ''
        // fetch student infos
        const r1 = await fetch(`${base}/etudiants/${this.studentId}/infos-moyennes`)
        const j1 = await r1.json()
        if (j1.status === 'success') {
          this.student = j1.data?.etudiant || null
        } else {
          this.student = null
        }

        // determine notes endpoint
        let notesResp
        if (/^S\d$/i.test(this.period)) {
          const sem = Number(this.period.slice(1))
          const r2 = await fetch(`${base}/notes/etudiant/${this.studentId}/semestre/${sem}`)
          notesResp = await r2.json()
        } else if (/^L\d$/i.test(this.period)) {
          const r2 = await fetch(`${base}/notes/etudiant/${this.studentId}/niveau/${this.period}`)
          notesResp = await r2.json()
        } else {
          this.notes = []
          this.loading = false
          return
        }

        if (notesResp && notesResp.status === 'success') {
          const raw = notesResp.data || []
          // normalize backend Note objects into { matiere, semestre, note, date, raw }
          this.notes = (Array.isArray(raw) ? raw : Object.values(raw)).map(entry => {
            const mat = entry.matiere?.libelle || entry.matiere_libelle || entry.ue || entry.libelle || (entry.matiere ? entry.matiere : null)
            const sem = entry.inscription?.semestre?.libelle || entry.semestre || entry.matiere?.semestre?.libelle || null
            // valeur can be number or object (BigDecimal serialized). Try to extract a usable value.
            let val = entry.valeur ?? entry.valeur_r ?? entry.note ?? null
            if (val && typeof val === 'object' && 'value' in val) val = val.value
            if (val && typeof val === 'object') {
              // fallback to toString
              try { val = JSON.stringify(val) } catch(e) { val = String(val) }
            }
            const date = entry.dateInsertion ?? entry.date_insertion ?? entry.date ?? null
            return { matiere: mat, semestre: sem, note: val, date: date, raw: entry }
          })
        } else {
          this.notes = []
          this.error = notesResp?.error?.message || 'Erreur récupération notes'
        }
      } catch (e) {
        this.error = e.message
        this.student = null
        this.notes = []
      } finally {
        this.loading = false
      }
    }
  },
  computed: {
    periodLabel() { return this.period || 'S1' }
  }
}
</script>

<style scoped>
table { width: 100%; border-collapse: collapse; }
th, td { padding: 6px 8px; border-bottom: 1px solid #eee }
</style>
