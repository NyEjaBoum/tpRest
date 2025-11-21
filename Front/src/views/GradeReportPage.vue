<template>
  <div>
    <GradeReport :studentId="id" :period="period" @back="onBack" />
  </div>
</template>

<script>
import GradeReport from '../components/GradeReport.vue'
export default {
  components: { GradeReport },
  props: ['id', 'period'],
  methods: {
    onBack() { this.$router.back() }
  }
}
</script>
