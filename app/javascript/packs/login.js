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
  }, { once: true })

  const startChefEmailPrompt = () => {
    link.style.height = '330px';

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

    link.addEventListener('webkitTransitionEnd', () => {
      link.appendChild(emailBoxLbl);
      link.appendChild(emailBox);
      link.appendChild(passwordBoxLbl);
      link.appendChild(passwordBox);
    });
  }
});
