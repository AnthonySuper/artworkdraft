(async function() {
  const Vue$ = await import("vue")
  const Vue = Vue$.default;
  const TA$ = await import("vue-turbolinks");
  const TurbolinksAdapter = TA$.default;
  Vue.use(TurbolinksAdapter);
  let cb = () => {
    let elm$ = document.querySelectorAll("[data-vue-component]");
    let elms = Array.prototype.slice.call(elm$);
    elms.forEach(async elm => {
      let compName = elm.dataset.vueComponent;
      let comp$ = await import(`./components/${compName}.vue`);
      let comp = comp$.default;
      let props = Object.assign({}, elm.dataset);
      console.log(`Loaded Vue "${compName}", rendering...`, { comp, props });
      let v = new Vue({
        el: elm,
        render: h => h(comp, {
          props: props
        }),
      });
    });
  };
  document.addEventListener("turbolinks:load", cb);
  cb();
})();
