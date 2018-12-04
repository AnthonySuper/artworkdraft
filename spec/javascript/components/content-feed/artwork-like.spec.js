import { shallowMount } from "@vue/test-utils";
import Scrap from "components/content-feed/artwork-like.vue";

const factory = (values = {}) => shallowMount(Scrap, {
  propsData: { ...values }
});

let defaultData = {
  id: 1,
  userName:  "TestUserName",
  userId: 1,
  name: "TestName",
  sourceLink: "/scraps/1",
  imageUrl: "/test",
};

describe("scrap.vue", () => {

  describe("With the default scrap", () => {
    const wrapper = factory(defaultData);

    it("Renders a link to the scrap", () => 
      expect(wrapper.find("a").attributes("href")).toEqual("/scraps/1"));

    it("Renders the name of the scrap", () => 
      expect(wrapper.text()).toContain("TestName"));

    it("Renders the name of the user", () =>
      expect(wrapper.text()).toContain("TestUserName"));

    it("Renders a link to the user", () =>
      expect(wrapper.find(`a[href="/users/1"]`).is("a")).toBeTruthy());

    it("Renders a link to the scrap", () =>
      expect(wrapper.find(`a[href="/scraps/1"]`).is("a")).toBeTruthy());
  });

});
