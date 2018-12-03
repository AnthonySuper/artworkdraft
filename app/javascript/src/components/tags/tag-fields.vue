<template>
  <tag-input v-model="tags" />
</template>

<script>
export default {
  data: function() {
    return { 
      tags: [{id: 1, name: "Dragon"}]
    };
  },
  components: {
    "tag-input": async () => {
      let q = await import("./tag-input.vue");
      return q.default;
    },
  },
}
</script>
