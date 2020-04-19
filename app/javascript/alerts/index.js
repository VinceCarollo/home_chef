export function showWarning(msg) {
  let alert = document.getElementById('alert')
  alert.style.display = 'inline-block'

  if (typeof msg === 'object') {
    let messages = ''
    for (let attribute in msg) {
      let attributeString = attribute.replace('_', ' ')
      let error = msg[attribute]

      messages = messages + attributeString.charAt(0).toUpperCase() + attributeString.slice(1) + ' '
      
      if (error.length > 1) { error = error[0] }

      messages = messages + error + '<br /> <br />'
    }
    
    alert.children[0].innerHTML = messages
  } else {
    alert.children[0].innerHTML = msg
  }
}

export function removeWarning() {
  document.getElementById('alert').style.display = 'none'
}
