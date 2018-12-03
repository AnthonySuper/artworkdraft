import { shallowMount } from "@vue/test-utils";
import TagSuggestion from "components/tags/tag-suggestion.vue";

const factory = (props = {}) => shallowMount(TagSuggestion, {
  propsData: { ...props }
});

describe("TagSuggestion", () => {
  it("Shows the name", () => {
    const wrapper = factory({tag: {name: "Foo"}});
    expect(wrapper.find("a").text()).toEqual("Foo");
  });
  it("Emits an event when clicked", () => {
    const wrapper = factory({tag: {}});
    wrapper.find("a").trigger("click");
    expect(wrapper.emitted("tag-clicked")).toBeTruthy();
  });
});
