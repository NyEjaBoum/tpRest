<template>
  <div>
    <StudentsList :semesterId="Number(id)" @show-student="onShowStudent" @show-grade="onShowGrade" />
  </div>
</template>

<script>
import StudentsList from '../components/StudentsList.vue'
export default {
  components: { StudentsList },
  props: ['id'],
  methods: {
    onShowStudent(studentId) {
      this.$router.push({ name: 'student', params: { id: studentId } })
    },
    onShowGrade({ studentId, period }) {
      this.$router.push({ name: 'grade', params: { id: studentId, period } })
    }
  }
}
</script>
