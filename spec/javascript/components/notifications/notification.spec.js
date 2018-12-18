import { shallowMount } from "@vue/test-utils";
import Notification from "components/notifications/notification.vue";

const factory = (props = {}) => shallowMount(Notification, {
  propsData:  {...props},
});

describe("notifications.vue", () => {
  describe("data types", () => {
    let factory_ = (data) => factory({
      id: 1,
      read: false,
      payload: data
    });
    
    describe("USER_COMMENTED", () => {
      const wrapper = factory_({
        type: "USER_COMMENTED",
        data: {
          commented_id: 2,
          commenter_id: 2,
          commented_type: "scrap",
          commenter_name: "2test"
        },
      });
      it("renders the word commented", () => 
        expect(wrapper.text()).toContain("commented"));
      it("renders the user's name", () =>
        expect(wrapper.text()).toContain("2test"));
      it("renders a link to the commentable", () =>
        expect(wrapper.find("a").attributes("href"))
          .toEqual("/scraps/2"));
    });
    describe("USER_FOLLOWED", () => {
      const wrapper = factory_({
        type: "USER_FOLLOWED",
        data: {
          follower_id: 2,
          follower_name: "2test"
        }
      });
      it("renders the word followed", () =>
        expect(wrapper.text()).toContain("followed"));
      it("renders the follower's name", () =>
        expect(wrapper.text()).toContain("2test"));
      it("renders a link to the follower", () =>
        expect(wrapper.find("a").attributes("href"))
          .toEqual("/users/2"));
    });
    describe("USER_REBLOGGED", () => {
      const wrapper = factory_({
        type: "USER_REBLOGGED",
        data: {
          reblog_id: 1,
          artwork_id: 1,
          reblogger_id: 2,
          reblogger_name: "2test"
        }
      });
      it("renders the word reblogged", () =>
        expect(wrapper.text()).toContain("reblogged"));
      it("renders the reblogger's name", () =>
        expect(wrapper.text()).toContain("2test"));
      it("renders a link to the reblog", () =>
        expect(wrapper.find("a").attributes("href"))
          .toEqual("/artwork_reblogs/1"));
    });
  });
});
