export function showWarning(msg) {
  let alert = document.getElementById('alert')
  alert.style.display = 'inline-block'

  if(typeof msg === 'object') {
    let messages = ''
    for (let attribute in msg) {
      let attributeString = attribute.replace('_', ' ')
      messages = messages + attributeString.charAt(0).toUpperCase() + attributeString.slice(1) + ' '
      messages = messages + msg[attribute] + '<br /> <br />'
    }
    
    alert.children[0].innerHTML = messages
  } else {
    alert.children[0].innerHTML = msg
  }
}

export function removeWarning() {
  document.getElementById('alert').style.display = 'none'
}
