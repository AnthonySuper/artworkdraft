<template>
  <section class="section">
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
  },
};
</script>
