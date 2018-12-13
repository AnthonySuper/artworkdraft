document.addEventListener("turbolinks:load", () => {
  const q$ = document.querySelectorAll(".is-button-notification");
  const q = Array.prototype.slice.call(q$);
  console.log(q);
  q.forEach(elm => {
    b = elm.querySelector("button");
    if(! b) return;
    b.addEventListener("click", () => {
      elm.style.display = "none";
    });
  });
});
