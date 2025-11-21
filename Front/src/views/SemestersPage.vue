<template>
  <div>
    <SemestersList @open-semester="onOpen" />
  </div>
</template>

<script>
import SemestersList from '../components/SemestersList.vue'
export default {
  components: { SemestersList },
  methods: {
    onOpen(id) {
      this.$router.push({ name: 'students', params: { id } })
    }
  }
}
</script>
