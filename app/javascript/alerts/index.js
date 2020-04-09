export function showWarning(msg) {
  let alert = document.getElementById('alert')
  alert.style.display = 'inline-block'
  alert.style.backgroundColor = '#9e1c1c'
  alert.children[0].innerHTML = 'Passwords do not match'
}

export function removeWarning() {
  document.getElementById('alert').style.display = 'none'
}
