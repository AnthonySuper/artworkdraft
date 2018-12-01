<template>
  <span class="tag is-medium">
    <a :href="tagLink" target="_blank">
      {{tagName}} 
    </a>
    <button class="delete is-medium" v-on:click="removeTag" />
  </span>
</template>


<script>
export default {
  props: ["tagName", "tagId"],
  methods: {
    removeTag: function() {
      this.$emit("remove-tag", this.tagId);
    },
  },
  computed: {
    tagLink: function() {
      return `/tags/${this.tagId}`;
    }
  }
};
</script>
