<template>
  <div class="navbar-item has-dropdown"
       :class="{'is-active': dropdownVisible}">
    <a class="navbar-link is-arrowless"
       @click="toggleDropdown">
      <i class="material-icons notification-icon"
         :data-notification-count="unreadCount">
        notifications
      </i>
    </a>
    <div class="navbar-dropdown is-right">
      <notification v-bind="notification"
                    v-for="notification in notifications"
                    @notification-changed="updateNotification"
                    :key="notification.id">
      </notification>
    </div>
  </div>
</template>
<script>
import { getJSON } from "../../lib/fetch.js";
import Notification from "./notification.vue";

export default {
  props: {
    notificationCount: String,
  },
  data: () => ({
    notificationMap: {},
    dropdownVisible: false,
  }),
  computed: {
    unreadCount: function() {
      if(this.notifications.length > 0) {
        return this.unreadNotifications.length;
      }
      else {
        return this.notificationCount;
      }
    },
    unreadNotifications: function() {
      return this.notifications.filter(n => n.read === false);
    },
    notifications: function() {
      return Object.values(this.notificationMap)
        .sort((a, b) => (new Date(b.created_at)) - (new Date(a.created_at)));
    }
  },
  methods: {
    toggleDropdown() {
      this.dropdownVisible = ! this.dropdownVisible;
      if(this.dropdownVisible) {
        this.getNotifications();
      }
    },
    updateNotification(id, notification) {
      this.$set(this.notificationMap, id, notification);
    },
    async getNotifications() {
      const notes = await getJSON("/notifications");
      notes.forEach(n => this.updateNotification(n.id, n));
    },
  },
  components: {
    Notification,
  },
};
</script>
