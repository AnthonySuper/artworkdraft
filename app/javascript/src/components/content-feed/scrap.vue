<template>
  <artwork-like
    v-bind="artworkParams" />
</template>
<script>

export default {
  props: {
    id: Number,
    name: String,
    description: String,
    user: {
      name: String,
      id: Number,
      avatar: String,
    },
    image_url: String
  },
  computed: {
    scrapLink: function() {
      return `/scraps/${this.id}`;
    },
    artworkParams: function() {
      return {
        name: this.name,
        description: this.description,
        sourceLink: this.scrapLink,
        userAvatar: this.user.avatar,
        userName: this.user.name,
        userId: this.user.id,
        imageUrl: this.image_url,
      };
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
