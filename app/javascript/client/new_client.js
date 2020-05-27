import showMsg from '../messages/index'

const newChef = () => {
  let password = document.getElementById('password')
  let passwordConf = document.getElementById('password_confirmation')
  
  passwordConf.addEventListener('focusout', () => {
    if (password.value != passwordConf.value) {
      showMsg('Paswords Do Not Match', 'warning')
    }
  })

  password.addEventListener('focusout', () => {
    if (passwordConf.value != '' && password.value != passwordConf.value) {
      showMsg('Passwords Do Not Match', 'warning')
    }
  })
}

export default newChef
