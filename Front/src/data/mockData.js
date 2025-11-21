export const students = [
  { id: 1, nom: 'Alice Dupont', option: 'Informatique', moyennes: { s1: 14.2, s2: 13.5, s3: 15.0, s4: 14.6 } },
  { id: 2, nom: 'Boris Martin', option: 'Maths', moyennes: { s1: 12.0, s2: 12.8, s3: 13.3, s4: 12.9 } },
  { id: 3, nom: 'Carla Rossi', option: 'Physique', moyennes: { s1: 16.1, s2: 15.7, s3: 16.4, s4: 16.0 } }
]

export function getStudentById(id) {
  return students.find(s => Number(s.id) === Number(id)) || null
}
