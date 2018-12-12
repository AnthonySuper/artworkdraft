<template>
  <div>
    <template v-for="comp in feedItems" v-if="hasItems">
      <type-splitter v-bind="comp" @fetch-further="fetchFurther" />
    </template>
    <template v-if="hasNothing">
      <h1 class="title">
        No items in feed
      </h1>
      <h2 class="subtitle">
        Either there's nothing here or something went horribly wrong.
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

function mergeObjects(obj, array) {
  let o = Object.assign({}, obj);
  array.forEach(a => o[a.id] = a);
  return o;
}
export default {
  props: {
    baseUrl: {
      type: String,
      default: "/feeds/"
    },
  },
  data: function() {
    const time = (new Date()).getTime();
    return {
      reblogs: {},
      artworks: {},
      scraps: {},
      reblogMinDate: time,
      artworkMinDate: time,
      scrapMinDate: time,
      loadingCount: 0,
      fetchedInitial: false,
    };
  },
  async created() {
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
    },
    fetcherItems: function() {
      return [
        this.makeFetcher(this.artworkMinDate, "artwork"),
        this.makeFetcher(this.reblogMinDate, "reblog"),
        this.makeFetcher(this.scrapMinDate, "scrap"),
      ];
    },
    feedItems: function() {
      let arr = [].concat(this.artworksArray)
        .concat(this.reblogsArray)
        .concat(this.scrapsArray)
        .concat(this.fetcherItems);
      return arr.sort((a, b) => b.sortDate - a.sortDate);
    },
    artworksArray: function() {
      return Object.values(this.artworks);
    },
    reblogsArray: function() {
      return Object.values(this.reblogs);
    },
    scrapsArray: function() {
      return Object.values(this.scraps);
    },
  },
  methods: {
    makeFetcher(created, type) {
      return {
        type: "feed-fetcher",
        sortDate: (new Date(created)),
        data: {
          type: type,
        },
      };
    },
    startLoading() {
      this.loadingCount = this.loadingCount + 1;
    },
    endLoading() { 
      this.loadingCount = this.loadingCount - 1;
    },
    getBase(string) {
      return getJSON(`${this.baseUrl}/${string}`);
    },
    afterTime: function(time) {
      if(! time) {
        time = new Date();
      }
      if(time.getTime) {
        return time.getTime() / 1000.0;
      }
      else return time / 1000.0;
    },
    abstractFetch: async function(after, type, url) {
      console.log("Abstract fetch");
      this.startLoading();
      const time = this.afterTime(after);
      try {
        let up = await this.getBase(`${url}?after=${time}`);
        console.log(up);
        let process = up.map(a => ({
          data: a,
          type: type,
          sortDate: new Date(a.created_at),
          id: `${type}-${a.id}`,
        }));
        const typeKey = `${type}s`;
        this[typeKey] = mergeObjects(this[typeKey], process);
        this[`${type}MinDate`] = Math.min(...this[typeKey]);
      }
      finally {
        this.endLoading();
      }
    },
    getArtworks: async function() {
      const after = this.artworkMinDate;
      return await this.abstractFetch(after, "artwork", "artworks");
    },
    getScraps: async function() {
      const after = this.scrapMinDate;
      return await this.abstractFetch(after, "scrap", "scraps");
    },
    getReblogs: async function() {
      const after = this.reblogMinDate;
      return await this.abstractFetch(after, "reblog", "artwork_reblogs");
    },
    fetchFurther: async function(key) {
      if(key === "artwork") {
        return await this.getArtworks();
      } else if(key === "scrap") {
        return await this.getScraps();
      } else if(key === "reblog") {
        return await this.getReblogs();
      }
    }
  },
};
</script>
