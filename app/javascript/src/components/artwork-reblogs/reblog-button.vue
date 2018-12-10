<template>
  <reblog-form v-if="showForm"
               @reblog-created="setSubmit"
               @reblog-canceled="setCanceled"
               :ancestor-id="ancestorId"
               :artwork-id="artworkId">
  </reblog-form>
  <a v-else-if="hasSubmitted">
    <i class="material-icons">check</i>
  </a>
  <a v-else href="#" v-on:click="clickButton">
    <i class="material-icons">replay</i>
  </a>
</template>

<script>
export default {
  props: ["artworkId", "ancestorId"],
  data: () => ({showForm: false, hasSubmitted: false}),
  methods: {
    clickButton: function(evt) {
      evt.preventDefault();
      this.showForm = true;
    },
    setSubmit: function() {
      this.showForm = false;
      this.hasSubmitted = true;
    },
    setCanceled: function() {
      this.showForm = false;
      this.hasSubmitted = false;
    }
  },
  components: {
    "reblog-form": async () => {
      let comp = await import("./reblog-form.vue");
      return comp.default;
    },
  },
};
</script>
