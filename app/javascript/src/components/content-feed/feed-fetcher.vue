<template>
  <intersect @enter="fetchFurther">
    <div></div>
  </intersect>
</template>
<script>
import Intersect from "vue-intersect"

export default {
  components: { Intersect },
  props: {
    type: String,
  },
  methods: {
    fetchFurther() {
      this.$emit("fetch-further", this.type)
    },
  },
};
</script>
