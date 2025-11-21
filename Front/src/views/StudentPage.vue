<template>
  <div>
    <StudentDetail :studentId="id" @show-grade="onShowGrade" @back="onBack" />
  </div>
</template>

<script>
import StudentDetail from '../components/StudentDetail.vue'
export default {
  components: { StudentDetail },
  props: ['id'],
  methods: {
    onShowGrade({ studentId, period }) {
      this.$router.push({ name: 'grade', params: { id: studentId, period } })
    },
    onBack() {
      this.$router.back()
    }
  }
}
</script>
