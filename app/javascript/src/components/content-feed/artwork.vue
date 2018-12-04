<template>
  <artwork-like
    v-bind="artworkParams" />
</template>
<script>
export default {
  props: {
    id: Number,
    name: String,
    user: {
      id: Number,
      name: String,
      avatar: String,
    },
    description: String,
    image_url: String,
  },
  computed: {
    artworkLink: function() {
      return `/artworks/${this.id}`;
    },
    artworkParams: function() {
      return {
        userName: this.user.name,
        userId: this.user.id,
        userAvatar: this.user.avatar,
        imageUrl: this.image_url,
        sourceLink: this.artworkLink,
      }
    },
  },
  components: {
    "artwork-like": async () => {
      let c = await import("./artwork-like.vue");
      return c.default;
    },
  },
};
</script>
