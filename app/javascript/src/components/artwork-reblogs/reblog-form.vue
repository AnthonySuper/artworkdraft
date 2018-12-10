<template>
  <div class="modal is-active">
    <div class="modal-background"></div>
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">Reblog Artwork</p>
        <button class="delete" 
                aria-label="close"
                @click="cancelReblog"></button>
      </header>
      <section class="modal-card-body">
        <form class="form" v-on:submit="submitForm">
          <div class="field">
            <label class="label" for="comment">
              Add a comment (optional)
            </label>
            <textarea class="textarea" v-model="comment" />
          </div>
          
          <button class="button">
            Reblog
          </button>
        </form>
      </section>
    </div>
  </div>
</template>

<script>
import { postJSON } from "../../lib/fetch.js";

export default {
  props: ["artworkId", "ancestorId"],
  data: () => ({ comment: "" }),
  computed: {
    formData: function() {
      let rb = { comment: this.comment }
      if(this.ancestorId) {
        rb.ancestor_id = this.ancestorId;
      }
      else {
        rb.artwork_id = this.artworkId;
      }

      return {
        artwork_reblog: rb,
      };
    },
  },
  methods: {
    submitForm: async function(evt) {
      evt.preventDefault();
      console.log(this.formData);
      const resp = await postJSON("/artwork_reblogs", this.formData);
      this.$emit("reblog-created", resp);
    },
    cancelReblog: function() {
      this.$emit("reblog-canceled");
    },
  },
};
</script>

<style>
.modal-card-head p:not(:last-child) {
  margin-bottom: 0;
}
</style>
