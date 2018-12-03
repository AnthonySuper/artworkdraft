export function getCSRF() {
  const csrfelm = document.head.querySelector("[name='csrf-token']");
  if(csrfelm) return csrfelm.content
  else return "";
}

export function postJSON(endpoint, json) {
  return fetch(endpoint, {
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-CSRF-Token": getCSRF(),
    },
    body: JSON.stringify(json),
    method: "POST",
  });
};

