<template>
  <div class="new-tags-form">
    <div v-for="tag in tags"
         :key="tag.id">
      <input type="hidden"
             :name="childFieldName"
             :value="tag.id" />
    </div>
    <tag-input v-model="tags" />
  </div>
</template>

<script>

export default {
  props: ["fieldName"],
  data: function() {
    return {
      tags: [],
    };
  },
  computed: {
    childFieldName: function() {
      return this.fieldName + "[]";
    }
  },
  components: {
    "tag-input": async () => {
      let t = await import("./tag-input.vue");
      return t.default;
    }
  },
};

</script>
