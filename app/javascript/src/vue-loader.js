import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks';
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  console.log("Turbolinks loaded!");
  let elm$ = document.querySelectorAll("[data-vue-component]");
  let elms = Array.prototype.slice.call(elm$);
  elms.forEach(async elm => {
    let compName = elm.dataset.vueComponent;
    console.log("Trying for comp", compName);
    let comp$ = await import(`./components/${compName}.vue`);
    let comp = comp$.default;
    let v = new Vue({
      el: elm,
      render: h => h(comp)
    });
    console.log({v, comp});
  });
});
