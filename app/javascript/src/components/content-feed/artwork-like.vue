<template>
  <div class="card-spacer">
    <div class="card">
      <header class="card-header">
        <p class="card-header-title">
          Following {{userName}}
        </p>
      </header>
      <a class="card-image centered-image-container" v-bind:href="sourceLink">
          <img v-bind:src="imageUrl" />
      </a>
      <div class="card-content">
        <div class="media">
          <div class="media-left">
            <a class="image is-64x64" v-bind:href="userLink">
              <img v-bind:src="userAvatar" />
            </a>
          </div>
          <div class="media-right">
            <h2 class="title">
              {{name}}
            </h2>
            <h3 class="subtitle">
              By {{userName}}
            </h3>
            <p class="content">
              <vue-markdown html="false">{{artworkDescription}}</vue-markdown>
            </p>
          </div>
        </div>
          <slot />
      </div>
    </div>
  </div>
</template>
<script>
import VueMarkdown from "vue-markdown";

export default {
  props: {
    userAvatar: String,
    name: String,
    userName: String,
    sourceLink: String,
    userId: Number,
    imageUrl: String,
    artworkDescription: String,
  },
  computed: {
    userLink: function() {
      return `/users/${this.userId}`;
    },
  },
  components: {
    "vue-markdown": VueMarkdown,
  },
}
</script>

<style>
.card-spacer {
  margin: 1.5rem 0;
}
</style>
