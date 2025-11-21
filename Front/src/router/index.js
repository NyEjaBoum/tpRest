import { createRouter, createWebHistory } from 'vue-router'
import SemestersPage from '../views/SemestersPage.vue'
import StudentsPage from '../views/StudentsPage.vue'
import StudentPage from '../views/StudentPage.vue'
import GradeReportPage from '../views/GradeReportPage.vue'

const routes = [
  { path: '/', redirect: '/semesters' },
  { path: '/semesters', name: 'semesters', component: SemestersPage },
  { path: '/semesters/:id/students', name: 'students', component: StudentsPage, props: true },
  { path: '/student/:id', name: 'student', component: StudentPage, props: true },
  { path: '/student/:id/grade/:period', name: 'grade', component: GradeReportPage, props: true }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
