<template>
  <div class="navbar-item notification-item">
    <a class="description" :href="link">
    {{description}}
    </a>
    <nav class="level">
      <div class="level-item">
        <a @click="readNotification">
          <i class="material-icons">
            {{mailIcon}}
          </i>
        </a>
      </div>
      <div class="level-item">
        <a @click="deleteNotification">
          <i class="material-icons">
            delete
          </i>
        </a>
      </div>
    </nav>
  </div>
</template>
<script>

import { putJSON, deleteJSON } from "../../lib/fetch.js";

export default {
  props: {
    payload: {
      type: Object,
    },
    id: Number,
    read: Boolean,
  },
  computed: {
    mailIcon() {
      if(this.read) {
        return "mail_outline";
      }
      else {
        return "email";
      }
    },
    description: function() {
      const pl = this.payload;
      switch(pl.type) {
        case "USER_REBLOGGED":
          return `${pl.data.reblogger_name} reblogged you`;
        case "USER_FOLLOWED":
          return `${pl.data.follower_name} followed you`;
        case "USER_COMMENTED":
          let t = pl.data.commented_type;
          return `${pl.data.commenter_name} commented on your ${t}`;
        default:
          return "If you're seeing this we have a bug. Oops.";
      }
    },
    link: function() {
      const pl = this.payload;
      switch(pl.type) {
        case "USER_REBLOGGED":
          return `/artwork_reblogs/${pl.data.reblog_id}`;
        case "USER_FOLLOWED":
          return `/users/${pl.data.follower_id}`;
        case "USER_COMMENTED":
          return `/${pl.data.commented_type}s/${pl.data.commented_id}`;
        default:
          return "/";
      };
    },
  },
  methods: {
    async readNotification() {
      let read = ! this.read
      let payload = { notification: { read } };
      const note = await putJSON(`/notifications/${this.id}`, payload);
      this.$emit("notification-changed", this.id, note);
    },
    async deleteNotification() {
      await deleteJSON(`/notifications/${this.id}`, {});
      this.$emit("notification-changed", this.id, null);
    },
  }
};
</script>
<style>
.notification-item {
  flex-direction: column;
}

.notification-item nav {
  width: 100%;
}
</style>
