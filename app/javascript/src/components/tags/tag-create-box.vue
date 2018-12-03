<template>
  <form class="form content box" onSubmit="submitForm">
    <h5 class="subtitle">Create new tag</h5>
    <div class="field">
      <label class="label">Name</label>
      <input type="text" v-model="name" class="input" />
    </div>

    <div class="field">
      <label class="label">Description</label>
      <textarea v-model="description" class="textarea" />
    </div>

    <div class="field">
      <label class="label">
        <input type="checkbox" class="checkbox" v-model="nsfw">
        NSFW?
      </label>
    </div>

    <button type="button" v-on:click="submitForm" class="button">
      Create Tag
    </button>
  </form>
</template>

<script>
export default {
  data: function() {
    return {
      nsfw: false,
      name: "",
      description: ""
    }
  },
  methods: {
    submitForm: async function(evt) {
      evt.preventDefault();
      const fetchLib = await import("../../lib/fetch.js");
      const payload = {
        tag: {
          nsfw: this.nsfw,
          name: this.name,
          description: this.description
        }
      };
      const resp = await fetchLib.postJSON("/tags", payload);
      const body = await resp.json();
      this.$emit("tag-created", body);
      this.nsfw = false;
      this.name = "";
      this.body = "";
    },
  },
};
</script>
