<template>
  <artwork v-bind="data" v-if="isArtwork"/>
  <scrap v-bind="data"  v-else-if="isScrap"/>
  <div class="card" v-else>
    <h1 class="title">
      Oopsy Whoopsy
    </h1>
    <h2 class="subtitle">
      Something went very wrong
    </h2>
  </div>
</template>
<script>
import Scrap from "./scrap.vue";
import Artwork from "./artwork.vue";

export default {
  props: {
    type: String,
    data: Object
  },
  computed: {
    isScrap: function() {
      return this.type === "scrap";
    },
    isArtwork: function() {
      return this.type == "artwork";
    },
  },
  components: {
    scrap: Scrap,
    artwork: Artwork
  },
}
</script>
