document.addEventListener("turbolinks:load", async function() {
  let elms$ = document.querySelectorAll(".is-previewed-file");
  let elms = Array.prototype.slice.call(elms$);
  if(elms.length === 0) return;
  let { changeField } = await import("./misc/file-field.js");
  elms.forEach(elm => elm.addEventListener("change", changeField));
});
