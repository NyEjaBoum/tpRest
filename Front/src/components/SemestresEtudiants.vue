<template>
  <div class="p-4">
    <h2 class="text-xl font-bold mb-4">Liste des semestres</h2>
    <ul class="mb-6">
      <li v-for="sem in semestres" :key="sem.idSemestre">
        <a href="#" @click.prevent="chargerEtudiants(sem)" class="text-blue-600 underline">
          {{ sem.libelle }}
        </a>
      </li>
    </ul>

    <div v-if="etudiants.length > 0">
      <h3 class="text-lg font-semibold mb-2">Étudiants du semestre {{ semestreCourant?.libelle }}</h3>
      <table class="min-w-full border">
        <thead>
          <tr>
            <th class="border px-2 py-1">Nom</th>
            <th class="border px-2 py-1">Prénom</th>
            <th class="border px-2 py-1" v-for="s in semestres" :key="s.idSemestre">
              Moyenne {{ s.libelle }}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="etu in etudiants" :key="etu.etudiant.idEtudiant">
            <td class="border px-2 py-1">{{ etu.etudiant.nom }}</td>
            <td class="border px-2 py-1">{{ etu.etudiant.prenom }}</td>
            <td class="border px-2 py-1" v-for="s in semestres" :key="s.idSemestre">
              {{ etu['moyenne_' + s.libelle] !== null && etu['moyenne_' + s.libelle] !== undefined ? etu['moyenne_' + s.libelle].toFixed(2) : '-' }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else-if="semestreCourant">
      <p>Aucun étudiant pour ce semestre.</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'SemestresEtudiants',
  data() {
    return {
      semestres: [],
      etudiants: [],
      semestreCourant: null
    }
  },
  mounted() {
    this.chargerSemestres()
  },
  methods: {
    async chargerSemestres() {
      const res = await axios.get('http://localhost:8080/api/semestres')
      this.semestres = res.data
    },
    async chargerEtudiants(semestre) {
      this.semestreCourant = semestre
      const res = await axios.get(`http://localhost:8080/api/semestres/semestres/${semestre.idSemestre}/etudiants-moyennes`)
      this.etudiants = res.data
    }
  }
}
</script>