<template>
  <div v-if="needsFetch">
    <progress />
  </div>
  <div class="new-tags-form" v-else>
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

import { getJSON } from "../../lib/fetch.js";

export default {
  props: {
    fieldName: String,
    allowCreate: {
      type: String,
      default: "",
    },
    fieldPreloadUrl: {
      type: String,
      default: ""
    },
    fieldPreloadPath: {
      type: String,
      default: ""
    },
  },
  created() {
    this.fetchInitial();
  },
  data: function() {
    return {
      tags: [],
      hasFetched: false,
    };
  },
  computed: {
    childFieldName() {
      return this.fieldName + "[]";
    },
    allowCreateBool() {
      return this.allowCreate !== "";
    },
    needsFetch() {
      return this.fieldPreloadUrl !== "" && ! this.hasFetched;
    },
  },
  components: {
    "tag-input": async () => {
      let t = await import("./tag-input.vue");
      return t.default;
    }
  },
  methods: {
    fetchInitial: async function() {
      if(! this.needsFetch) return;
      let s = await getJSON(this.fieldPreloadUrl);
      this.tags = s[this.fieldPreloadPath];
      this.hasFetched = true;
    },
  },
};

</script>
