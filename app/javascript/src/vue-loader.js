import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks';
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  let elm$ = document.querySelectorAll("[data-vue-component]");
  let elms = Array.prototype.slice.call(elm$);
  elms.forEach(async elm => {
    let compName = elm.dataset.vueComponent;
    let comp$ = await import(`./components/${compName}.vue`);
    let comp = comp$.default;
    console.log(`Loaded Vue "${compName}", rendering...`, { comp });
    let v = new Vue({
      el: elm,
      render: h => h(comp)
    });
  });
});
