import { showWarning, removeWarning } from '../alerts/index'

const newChef = () => {
  let password = document.getElementById("chef_password")
  let passwordConf = document.getElementById("chef_password_confirmation")

  passwordConf.addEventListener('focusout', () => {
    if (password.value != passwordConf.value) {
      showWarning('Paswords do not match')
    } else {
      removeWarning();
    }
  })

  password.addEventListener('keyup', () => {
    if (passwordConf.value != '') {
      if (password.value != passwordConf.value) {
        showWarning('Paswords do not match')
      } else {
        removeWarning();
      }
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
          showWarning('You must be available atleast one day')
          return false
        }
      })
      .on("ajax:error", (e) => {
        let status = e.originalEvent.detail[2].status
        let response = e.originalEvent.detail[2].response
        
        if (status === 422) { 
          showWarning(JSON.parse(response));
        } else {
          showWarning('An error occurred, please try again');
        }
      })
      .on("ajax:success", () => {
        window.location.href = '/chefs/dashboard'
      });
  });
}

export default newChef