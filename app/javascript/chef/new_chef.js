import { showWarning, removeWarning } from '../alerts/index'

const newChef = () => {
  let password = document.getElementById("chef_password")
  let passwordConf = document.getElementById("chef_password_confirmation")

  passwordConf.addEventListener('keyup', () => {
    if(password.value != passwordConf.value) {
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
    console.log('hi');

    $('#new-chef-form')
      .on("ajax:error", (e) => {
        let status = e.originalEvent.detail[2].status
        let response = e.originalEvent.detail[2].response
        
        if(status === 422) { 
          showWarning(JSON.parse(response));
        } else {
          showWarning('An error occurred, please try again');
        }
      })
      .on("ajax:success", (event, data, status, xhr) => {
        console.log(event);
        console.log(data);
        console.log(status);
        console.log(xhr);
      });
  });
}

export default newChef