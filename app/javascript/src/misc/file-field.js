
export function changeField(evt) {
  let previewField = evt.target.dataset.filePreviewContainer;
  if(! previewField) return;
  let reader = new FileReader();
  let file = evt.target.files[0];
  reader.onload = function() {
    let output = document.getElementById(previewField);
    output.src = reader.result;
  }
  reader.readAsDataURL(file);
  let nameField = evt.target.parentElement.querySelector(".file-name");
  nameField.innerText = file.name;
}
