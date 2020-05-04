import Rails from '@rails/ujs'
import { showWarning, removeWarning } from '../alerts';

document.addEventListener('DOMContentLoaded', () => {
  const link = document.getElementById('login-box');

  link.addEventListener('click', () => {
    link.style.width = '320px';
    link.style.height = '107px';
    link.style.backgroundColor = 'white';
    link.style.fontSize = '50px';
    link.style.color = 'black';
    
    let chefButton = document.createElement('BUTTON');
    let clientButton = document.createElement('BUTTON');
    
    chefButton.setAttribute('class', 'login-choices');
    clientButton.setAttribute('class', 'login-choices');
    
    chefButton.innerHTML = 'Chef';
    clientButton.innerHTML = 'Client';
    
    link.addEventListener('webkitTransitionEnd', () => {
      link.append(chefButton);
      link.append(clientButton);
    })

    chefButton.addEventListener('click', () => {
      startChefEmailPrompt();
    })

    clientButton.addEventListener('click', () => {
      // startClientEmailPrompt();
    })
  }, { once: true })

  const startClientEmailPrompt = () => {
    let emailBox = document.createElement('INPUT');
    let emailBoxLbl = document.createElement('LABEL');

    emailBoxLbl.innerHTML = 'Chef Email';
    emailBox.setAttribute("type", "text");
    emailBox.setAttribute("id", "email-box");
    emailBoxLbl.setAttribute("id", "login-email-lbl");
    emailBoxLbl.setAttribute("for", "email-box");

    let passwordBox = document.createElement('INPUT');
    let passwordBoxLbl = document.createElement('LABEL');

    passwordBoxLbl.innerHTML = 'Password';
    passwordBox.setAttribute("type", "password");
    passwordBox.setAttribute("id", "password-box");
    passwordBoxLbl.setAttribute("id", "login-password-lbl");
    passwordBoxLbl.setAttribute("for", "password-box");

    let submitButton = document.createElement('INPUT')

    submitButton.setAttribute('type', 'submit')
    submitButton.setAttribute('id', 'login-submit-button')
    submitButton.setAttribute('value', 'Login')

    link.appendChild(emailBoxLbl);
    link.appendChild(emailBox);
    link.appendChild(passwordBoxLbl);
    link.appendChild(passwordBox);
    link.appendChild(submitButton);
  }

  const startChefEmailPrompt = () => {
    link.style.height = '350px';

    let emailBox = document.createElement('INPUT');
    let emailBoxLbl = document.createElement('LABEL');

    emailBoxLbl.innerHTML = 'Chef Email';
    emailBox.setAttribute("type", "text");
    emailBox.setAttribute("id", "email-box");
    emailBoxLbl.setAttribute("id", "login-email-lbl");
    emailBoxLbl.setAttribute("for", "email-box");

    let passwordBox = document.createElement('INPUT');
    let passwordBoxLbl = document.createElement('LABEL');

    passwordBoxLbl.innerHTML = 'Password';
    passwordBox.setAttribute("type", "password");
    passwordBox.setAttribute("id", "password-box");
    passwordBoxLbl.setAttribute("id", "login-password-lbl");
    passwordBoxLbl.setAttribute("for", "password-box");

    let submitButton = document.createElement('INPUT')

    submitButton.setAttribute('type', 'submit')
    submitButton.setAttribute('id', 'login-submit-button')
    submitButton.setAttribute('value', 'Login')

    link.addEventListener('webkitTransitionEnd', () => {
      link.appendChild(emailBoxLbl);
      link.appendChild(emailBox);
      link.appendChild(passwordBoxLbl);
      link.appendChild(passwordBox);
      link.appendChild(submitButton);
    });

    submitButton.addEventListener('click', () =>{
      if(emailBox.value == '' || passwordBox.value == '') {
        return
      }
      
      let data = {
        email: emailBox.value,
        password: passwordBox.value
      }
      
      Rails.ajax({
        url: '/chefs/login.js',
        type: 'POST',
        cache: false,
        contentType: 'application/json',
        data: new URLSearchParams(data).toString(),
        error: async (e) => {
          showWarning(e);
          await new Promise(r => setTimeout(r, 2000));
          removeWarning();
        },
        success: () => {
          let front_end_url = process.env.FRONT_END_URL || 'http://localhost:3000'
          window.location.href = front_end_url + '/chefs/dashboard'
        }
      })
    })
  }
});
