<template>
  <div class="card-spacer">
    <div class="card">
      <header class="card-header">
        <p class="card-header-title">
          {{appearReason_}}
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
              <!-- awkward spacing prevents markdown from seeing the first line
                as super indented -->
              <vue-markdown v-bind:html="false">{{artworkDescription}}
              </vue-markdown>
            </p>
          </div>
        </div>
          <slot />
      </div>
      <div class="card-footer footer-form-container" v-if="canReblog">
        <reblog-button :ancestor-id="reblogAncestorId"
          :artwork-id="reblogArtworkId" />
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
    appearReason: String,
    canReblog: {
      type: Boolean,
      default: false,
    },
    reblogArtworkId: Number,
    reblogAncestorId: Number,
  },
  computed: {
    userLink() {
      return `/users/${this.userId}`;
    },
    appearReason_() {
      if(this.appearReason) {
        return this.appearReason;
      }
      else {
        return `Following ${this.userName}`;
      }
    },
  },
  components: {
    "vue-markdown": VueMarkdown,
    "reblog-button": async () => {
      const c = await import("../artwork-reblogs/reblog-button.vue");
      return c.default;
    },
  },
}
</script>

<style>
.card-spacer {
  margin: 1.5rem 0;
}

.card-footer .material-icons {
  line-height: unset;
}

.card-footer.footer-form-container .section {
  flex-grow: 1;
  display: block;
}
</style>
