<template>
  <artwork v-bind="root_artwork">
    <reblog-ancestor
      v-for="ancestor in ancestors"
      v-bind="ancestor" />
  </artwork>
</template>
<script>
import Artwork from "./artwork.vue";
import ReblogAncestor from "./reblog-ancestor.vue";

export default {
  props: {
    root_artwork: Object,
    id: Number,
    comment: String,
    ancestors: Array
  },
  components: {
    "artwork": Artwork,
    "reblog-ancestor": ReblogAncestor,
  },
};
</script>
