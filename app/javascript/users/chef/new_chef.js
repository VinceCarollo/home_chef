import showMsg from '../../messages/index'

const newChef = () => {
  let password = document.getElementById("chef_password")
  let passwordConf = document.getElementById("chef_password_confirmation")

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
    $('#new-chef-form')
      .on("ajax:beforeSend", () => {
        let mondayBox = document.getElementById('chef_monday').checked
        let tuesdayBox = document.getElementById('chef_tuesday').checked
        let wednesdayBox = document.getElementById('chef_wednesday').checked
        let thursdayBox = document.getElementById('chef_thursday').checked
        let fridayBox = document.getElementById('chef_friday').checked
        let saturdayBox = document.getElementById('chef_saturday').checked
        let sundayBox = document.getElementById('chef_sunday').checked
        
        if (mondayBox || tuesdayBox || wednesdayBox || thursdayBox || fridayBox || saturdayBox || sundayBox) {
          return true
        } else {
          showMsg('You Must be Available Atleast One Day', 'warning')
          return false
        }
      })
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
        window.location.href = '/chefs/dashboard'
      });
  });
}

export default newChef