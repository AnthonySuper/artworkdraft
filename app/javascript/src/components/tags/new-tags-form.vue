<template>
  <div class="new-tags-form">
    <div v-for="tag in tags"
         :key="tag.id">
      <input type="hidden"
             :name="childFieldName"
             :value="tag.id" />
    </div>
    <tag-input v-model="tags" 
      v-bind:allow-create="allowCreateBool" />
  </div>
</template>

<script>

export default {
  props: {
    fieldName: String,
    allowCreate: {
      type: String,
      default: "",
    },
  },
  data: function() {
    return {
      tags: [],
    };
  },
  computed: {
    childFieldName() {
      return this.fieldName + "[]";
    },
    allowCreateBool() {
      return this.allowCreate !== "";
    },
  },
  components: {
    "tag-input": async () => {
      let t = await import("./tag-input.vue");
      return t.default;
    }
  },
};

</script>
