import Rails from '@rails/ujs'
import { showWarning, removeWarning } from '../alerts';

document.addEventListener('DOMContentLoaded', () => {
  const loginBox = document.getElementById('login-box');

  const resizeBoxForUserTypes = (box) => {
    loginBox.style.width = '320px';
    loginBox.style.height = '120px';
    loginBox.style.backgroundColor = 'white';
    loginBox.style.fontSize = '50px';
    loginBox.style.color = 'black';
  }

  const createButtonFor = (userType) => {
    if (userType === 'chef') {
      let button = document.createElement('BUTTON');
      button.setAttribute('class', 'login-choices')
      button.innerHTML = 'Chef'
      return button
    } else {
      let button = document.createElement('BUTTON');
      button.setAttribute('class', 'login-choices')
      button.innerHTML = 'Client'
      return button
    }
  }

  loginBox.addEventListener('click', () => {
    resizeBoxForUserTypes();

    let chefButton = createButtonFor('chef')
    let clientButton = createButtonFor('client')
        
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

  const createEmailInput = () => {
    let input = document.createElement('INPUT');
    input.setAttribute("type", "text");
    input.setAttribute("id", "email-box");
    return input
  }

  const createEmailInputLblFor = (userType) => {
    if (userType === 'chef') {
      let Lbl = document.createElement('LABEL');
      Lbl.innerHTML = 'Chef Email';
      Lbl.setAttribute("id", "login-email-lbl");
      Lbl.setAttribute("for", "email-box");
      return Lbl
    } else {
      let Lbl = document.createElement('LABEL');
      Lbl.innerHTML = 'Client Email';
      Lbl.setAttribute("id", "login-email-lbl");
      Lbl.setAttribute("for", "email-box");
      return Lbl
    }
  }

  const createPasswordInput = () => {
    let input = document.createElement('INPUT');
    input.setAttribute("type", "password");
    input.setAttribute("id", "password-box");
    return input
  }

  const createPasswordInputLbl = () => {
    let Lbl = document.createElement('LABEL');
    Lbl.innerHTML = 'Password';
    Lbl.setAttribute("id", "login-password-lbl");
    Lbl.setAttribute("for", "password-box");
    return Lbl
  }

  const createSubmitButton = () => {
    let button = document.createElement('INPUT')
    button.setAttribute('type', 'submit')
    button.setAttribute('id', 'login-submit-button')
    button.setAttribute('value', 'Login')
    return button
  }

  const appendLoginBoxChild = (elements) => {
    elements.forEach((elem) => { loginBox.appendChild(elem) })
  }

  const startChefEmailPrompt = () => {
    loginBox.style.height = '350px';

    let emailInput = createEmailInput();
    let emailInputLbl = createEmailInputLblFor('chef');

    let passwordInput = createPasswordInput();
    let passwordInputLbl = createPasswordInputLbl();

    let submitButton = createSubmitButton();

    loginBox.addEventListener('webkitTransitionEnd', () => {
      window.scrollTo({
        top: 200,
        behavior: 'smooth'
      });

      appendLoginBoxChild([emailInputLbl, emailInput, passwordInputLbl, passwordInput, submitButton])
    });

    submitButton.addEventListener('click', () =>{
      if (emailInput.value == '' || passwordInput.value == '') {
        return
      }
      
      let data = {
        email: emailInput.value,
        password: passwordInput.value
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
          window.location.href = '/chefs/dashboard'
        }
      })
    })
  }
});
