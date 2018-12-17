export function getCSRF() {
  const csrfelm = document.head.querySelector("[name='csrf-token']");
  if(csrfelm) return csrfelm.content
  else return "";
}

export function csrfFetch(method, endpoint, json) {
  return fetch(endpoint, {
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-CSRF-Token": getCSRF(),
    },
    body: JSON.stringify(json),
    method: method,
  }).then(a => a.json());
};

export let postJSON = csrfFetch.bind(null, "POST");

export let putJSON = csrfFetch.bind(null, "PUT");

export let deleteJSON = csrfFetch.bind(null, "DELETE");


export async function getJSON(endpoint) {
  let r = await fetch(endpoint, {
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }
  });
  return await r.json();
};
