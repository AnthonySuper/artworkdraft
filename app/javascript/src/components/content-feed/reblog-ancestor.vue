<template>
  <section class="media" v-if="hasComment">
    <figure class="media-left">
      <a class="image is-64x64" v-bind:href="userLink">
        <img v-bind:src="user.avatar" />
      </a>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
        <span><a v-bind:href="userLink">{{user.name}}</a> Reblogged</span>
        <timeago :datetime="created_at" :auto-update="60"></timeago>
        </p>
        <p class="content">
          <vue-markdown v-bind:html="false">{{comment}}</vue-markdown>
        </p>
      </div>
    </div>
  </section>
  <section class="tiny-reblog" v-else>
    <a class="image is-24x24"  v-bind:href="userLink">
      <img v-bind:src="user.avatar" />
    </a>
    <p><a v-bind:href="userLink">{{user.name}}</a>
    Reblogged
      <timeago v-bind:auto-update="60"
               :datetime="created_at"></timeago>
    </p>

  </section>
</template>
<script>

export default {
  props: {
    user: Object,
    comment: String,
    created_at: String,
  },
  computed: {
    userLink() {
      return `/users/${this.user.id}`;
    },
    hasComment() {
      return this.comment !== "";
    }
  },
  components: {
    "vue-markdown": async () => {
      const vm = await import("vue-markdown");
      return vm.default;
    },
    "timeago": async () => {
      const ti = await import("vue-timeago");
      return ti.createTimeago();
    },
  },
};
</script>

<style>
.tiny-reblog {
  display: flex;
  align-items: center;
  padding: 1rem 0;
  border-top: 1px solid #aaa;
}

.tiny-reblog a.image {
  margin-right: 0.5rem;
}
</style>
