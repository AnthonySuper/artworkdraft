<template>
  <div v-bind:class="{ active: isActive }" class="tag-suggestion">
    <a v-on:click="tagClicked">{{tag.name}}</a>
  </div>
</template>

<script>
export default {
  props: ["tag", "is-active"],
  methods: {
    tagClicked: function() {
      this.$emit("tag-clicked", this.tag);
    }
  },
};
</script>

<style>
.tag-suggestion {
  padding: 8px;
}

.tag-suggestion.active {
  font-weight: 900;
  background-color: #FFFFE0;
}
</style>
