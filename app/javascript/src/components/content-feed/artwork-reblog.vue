<template>
  <artwork v-bind="artworkParams">
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
    ancestors: Array,
    user: Object,
  },
  components: {
    "artwork": Artwork,
    "reblog-ancestor": ReblogAncestor,
  },
  computed: {
    artworkParams() {
      return Object.assign({}, 
        this.root_artwork,
        { 
          ancestorId: this.id, 
          appearReason: `Reblogged by ${this.user.name}`, 
        });
    },
  },
};
</script>
