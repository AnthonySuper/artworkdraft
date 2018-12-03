import { shallowMount } from "@vue/test-utils";
import RemoveableTag from "components/tags/removeable-tag.vue";

const factory = (values = {}) => shallowMount(RemoveableTag, {
    propsData: { ...values }
});

describe("removeable-tag.vue", () => {
  it("renders the tag name", () => {
    const wrapper = factory({tagName: "Foo"});
    expect(wrapper.find("a").text()).toEqual("Foo")
  });
  it("renders the tag link", () => {
    const wrapper = factory({tagId: "1"});
    expect(wrapper.find("a").attributes("href")).toEqual("/tags/1");
  });
  it("fires a removal event when the button is clicked", () => {
    const wrapper = factory({tagName: "Foo", tagId: "1"});
    wrapper.find("button").trigger("click");
    expect(wrapper.emitted("remove-tag")).toBeTruthy()
  });
});
