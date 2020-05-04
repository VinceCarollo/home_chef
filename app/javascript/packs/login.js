import Rails from '@rails/ujs'
import { showWarning, removeWarning } from '../alerts';

document.addEventListener('DOMContentLoaded', () => {
  const loginBox = document.getElementById('login-box');

  loginBox.addEventListener('click', () => {
    loginBox.style.width = '320px';
    loginBox.style.height = '107px';
    loginBox.style.backgroundColor = 'white';
    loginBox.style.fontSize = '50px';
    loginBox.style.color = 'black';
    
    let chefButton = document.createElement('BUTTON');
    let clientButton = document.createElement('BUTTON');
    
    chefButton.setAttribute('class', 'login-choices');
    clientButton.setAttribute('class', 'login-choices');
    
    chefButton.innerHTML = 'Chef';
    clientButton.innerHTML = 'Client';
    
    loginBox.addEventListener('webkitTransitionEnd', () => {
      loginBox.append(chefButton);
      loginBox.append(clientButton);
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

    loginBox.appendChild(emailBoxLbl);
    loginBox.appendChild(emailBox);
    loginBox.appendChild(passwordBoxLbl);
    loginBox.appendChild(passwordBox);
    loginBox.appendChild(submitButton);
  }

  const startChefEmailPrompt = () => {
    loginBox.style.height = '350px';

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

    loginBox.addEventListener('webkitTransitionEnd', () => {
      window.scrollTo({
        top: 200,
        behavior: 'smooth'
      });

      loginBox.appendChild(emailBoxLbl);
      loginBox.appendChild(emailBox);
      loginBox.appendChild(passwordBoxLbl);
      loginBox.appendChild(passwordBox);
      loginBox.appendChild(submitButton);
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
