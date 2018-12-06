<template>
  <section class="media" v-if="hasComment">
    <figure class="media-left">
      <a class="image is-64x64" v-bind:href="userLink">
        <img v-bind:src="user.avatar" />
      </a>
    </figure>
    <div class="media-content">
      <div class="content">
        <p><a v-bind:href="userLink">{{user.name}}</a> Reblogged</p>
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
    <p><a v-bind:href="userLink">{{user.name}}</a> Reblogged</p>
  </section>
</template>
<script>

export default {
  props: {
    user: Object,
    comment: String,
  },
  computed: {
    userLink() {
      return `/users/${this.user.id}`;
    },
  },
  components: {
    "vue-markdown": async () => {
      const vm = await import("vue-markdown");
      return vm.default;
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
  margin-right: 1rem;
}
</style>
