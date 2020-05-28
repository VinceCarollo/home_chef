import showMsg from '../messages/index'

const newChef = () => {
  let password = document.getElementById('client_password')
  let passwordConf = document.getElementById('client_password_confirmation')
  
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

  $(document).ready(() => {
    $('#new-client-form')
      .on("ajax:error", (e) => {
        let status = e.originalEvent.detail[2].status
        let response = e.originalEvent.detail[2].response

        if (status === 422) {
          showMsg(JSON.parse(response));
        } else {
          showMsg('An Error Occurred, Please Try Again Later', 'error');
        }
      })
      .on("ajax:success", () => {
        console.log('success');
      });
  });
}

export default newChef
