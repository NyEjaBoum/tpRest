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
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S1' })">{{ formatMoyenne(st.moyennes.s1) }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S2' })">{{ formatMoyenne(st.moyennes.s2) }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S3' })">{{ formatMoyenne(st.moyennes.s3) }}</td>
          <td class="text-center text-blue-600" @click.stop="$emit('show-grade', { studentId: st.id, period: 'S4' })">{{ formatMoyenne(st.moyennes.s4) }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'StudentsList',
  props: { semesterId: { type: Number, required: true } },
  data() {
    return {
      students: [],
      loading: false,
      error: null
    }
  },
  watch: {
    semesterId: {
      immediate: true,
      handler(newId) {
        this.fetchStudents(newId)
      }
    }
  },
  methods: {
    async fetchStudents(semId) {
      if (!semId) return
      this.loading = true
      this.error = null
      try {
        const base = import.meta.env.VITE_API_BASE_URL || ''
        // try specialized endpoint that returns students with moyennes
        // note: controller is mapped at /api/semestres and method at /{id}/etudiants-moyennes
        let res = await fetch(`${base}/semestres/${semId}/etudiants-moyennes`)
        let json = await res.json()
        if (json && json.status === 'success') {
          // json.data is expected to be a list of maps { etudiant: {...}, moyenne_<libelle>: value }
          this.students = (json.data || []).map(item => {
            const etu = item.etudiant || item.get?.('etudiant') || {}
            // collect moyennes keys
            const moy = {}
            Object.keys(item).forEach(k => {
              if (k.startsWith('moyenne_')) {
                const key = k.replace('moyenne_', '')
                moy[key] = item[k]
              }
            })
            return {
              id: etu.idEtudiant ?? etu.id ?? etu.id_etudiant,
              nom: etu.nom || `${etu.prenom || ''} ${etu.nom || ''}`,
              option: etu.option || (etu.semestre?.libelle || ''),
              moyennes: {
                s1: moy.S1 ?? moy['1'] ?? moy['S1'] ?? null,
                s2: moy.S2 ?? moy['2'] ?? moy['S2'] ?? null,
                s3: moy.S3 ?? moy['3'] ?? moy['S3'] ?? null,
                s4: moy.S4 ?? moy['4'] ?? moy['S4'] ?? null
              }
            }
          })
          this.loading = false
          return
        }

        // fallback: fetch plain etudiants list
        res = await fetch(`${base}/etudiants/semestre/${semId}`)
        json = await res.json()
        if (json.status === 'success') {
          // map plain etudiant objects to our shape (no moyennes)
          this.students = (json.data || []).map(etu => ({
            id: etu.idEtudiant ?? etu.id,
            nom: etu.nom,
            option: etu.option || (etu.semestre?.libelle || ''),
            moyennes: { s1: '-', s2: '-', s3: '-', s4: '-' }
          }))
        } else {
          this.error = json.error?.message || 'Erreur API'
          this.students = []
        }
      } catch (e) {
        this.error = e.message
        this.students = []
      } finally {
        this.loading = false
      }
    },
    formatMoyenne(v) {
      if (v === null || v === undefined) return '-'
      const n = Number(v)
      if (Number.isNaN(n)) return String(v)
      return Math.round(n * 100) / 100
    }
  }
}
</script>

<style scoped>
table { width: 100%; border-collapse: collapse; }
th, td { padding: 8px 6px; border-bottom: 1px solid #eee }
</style>
