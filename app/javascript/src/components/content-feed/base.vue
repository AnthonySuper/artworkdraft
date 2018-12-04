<template>
  <div class="section">
    <template v-for="comp in feedItems">
      <type-splitter v-bind="comp" />
    </template>
  </div>
</template>
<script>
import TypeSplitter from "./type-splitter.vue"
import { getJSON } from "../../lib/fetch.js";

export default {
  data: function() {
    return {feedItems: []};
  },
  created() {
    this.fetchData();
  },
  components: {
    "type-splitter": TypeSplitter
  },
  methods: {
    fetchData: async function() {
      let [arts$, scraps$] = await Promise.all([
        getJSON("/feeds/artworks"),
        getJSON("/feeds/scraps")
      ]);
      let arts = arts$.map(a => ({data: a, 
          type: "artwork", 
          sortDate: new Date(a.created_at),
          id: `artwork-${a.id}`
      }));
      let scraps = scraps$.map(s => ({
          data: s,
          type: "scrap",
          sortDate: new Date(s.created_at),
          id: `scrap-${s.id}`
      }));
      this.addFeedItems(arts.concat(scraps));
    },
    addFeedItems(comps) {
      let newItems = [...this.feedItems, ...comps];
      newItems.sort((a, b) => a.sortDate < b.sortDate);
      this.feedItems = newItems;
    },
  },
};
</script>
