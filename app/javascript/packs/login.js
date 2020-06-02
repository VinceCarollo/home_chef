import Rails from '@rails/ujs'
import showMsg from '../messages';

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

  const listenForButtonChoice = (chefButton, clientButton) => {
    chefButton.addEventListener('click', () => {
      window.location.href = '/chefs/login'
    })

    clientButton.addEventListener('click', () => {
    })
  }

  loginBox.addEventListener('click', () => {
    resizeBoxForUserTypes();

    let chefButton = createButtonFor('chef')
    let clientButton = createButtonFor('client')
        
    loginBox.addEventListener('webkitTransitionEnd', () => {
      loginBox.append(chefButton);
      loginBox.append(clientButton);
    })

    listenForButtonChoice(chefButton, clientButton);
  }, { once: true })
});
