<template>
  <div>
    <template v-for="comp in feedItems" v-if="hasItems">
      <type-splitter v-bind="comp" />
    </template>
    <template v-if="hasNothing">
      <h1 class="title">
        No items in feed
      </h1>
      <h2 class="subtitle">
        Maybe you need to <a href="/users/">follow some users?</a>
      </h2>
    </template>
    <template v-if="isLoading">
      <progress />
    </template>
  </div>
</template>
<script>
import TypeSplitter from "./type-splitter.vue"
import { getJSON } from "../../lib/fetch.js";

export default {
  props: {
    baseUrl: {
      type: String,
      default: "/feeds/"
    },
  },
  data: function() {
    return {
      feedItems: [],
      loadingCount: 0,
      fetchedInitial: false,
    };
  },
  created() {
    this.fetchData();
  },
  components: {
    "type-splitter": TypeSplitter
  },
  computed: {
    hasItems: function() {
      return this.feedItems.length > 0;
    },
    isLoading: function() {
      return this.loadingCount > 0;
    },
    hasNothing: function() {
      return this.fetchedInitial && ! this.hasItems;
    }
  },
  methods: {
    startLoading() {
      this.loadingCount = this.loadingCount + 1;
    },
    endLoading() { 
      this.loadingCount = this.loadingCount - 1;
    },
    getBase(string) {
      return getJSON(`${this.baseUrl}/${string}`);
    },
    fetchData: async function() {
      this.startLoading();
      let [arts$, scraps$, arbls$] = await Promise.all([
        this.getBase("artworks"),
        this.getBase("scraps"),
        this.getBase("artwork_reblogs"),
      ]);
      console.log(arbls$);
      let arts = arts$.map(a => ({
        data: a, 
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
      let arbls = arbls$.map(a => ({
        data: a,
        type: "artwork-reblog",
        sortDate: new Date(a.created_at),
        id: `artwork-reblog-${a.id}`,
      }));
      this.addFeedItems(arts.concat(scraps).concat(arbls));
      this.endLoading();
      this.fetchedInitial = true;
    },
    addFeedItems(comps) {
      let newItems = [...this.feedItems, ...comps];
      newItems.sort((a, b) => a.sortDate < b.sortDate);
      this.feedItems = newItems;
    },
  },
};
</script>
