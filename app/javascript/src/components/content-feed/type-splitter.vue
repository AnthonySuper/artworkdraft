<template>
  <artwork v-bind="data" v-if="isArtwork">
  </artwork>
  <scrap v-bind="data"  v-else-if="isScrap">
  </scrap>
  <artwork-reblog v-bind="data" v-else-if="isArtworkReblog">
  </artwork-reblog>
  <feed-fetcher v-bind="data" 
    v-else-if="isFeedFetcher" 
    @fetch-further="fetchFurther">
  </feed-fetcher>
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
import ArtworkReblog from "./artwork-reblog.vue";
import FeedFetcher from "./feed-fetcher.vue";

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
    isArtworkReblog: function() {
      return this.type == "reblog";
    },
    isFeedFetcher: function() {
      return this.type == "feed-fetcher";
    }
  },
  methods: {
    fetchFurther(arg) {
      this.$emit("fetch-further", arg);
    },
  },
  components: {
    scrap: Scrap,
    artwork: Artwork,
    "artwork-reblog": ArtworkReblog,
    "feed-fetcher": FeedFetcher,
  },
}
</script>
