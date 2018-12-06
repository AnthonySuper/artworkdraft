<template>
  <reblog-form v-if="showForm"
               v-on:reblog-created="setSubmit"
               v-bind:ancestor-id="ancestorId"
               v-bind:artwork-id="artworkId" />
  <i v-else-if="hasSubmitted" class="material-icons">check</i>
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
