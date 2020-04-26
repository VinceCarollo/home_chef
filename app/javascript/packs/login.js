document.addEventListener('DOMContentLoaded', () => {
  let link = document.getElementById('login-box');

  link.addEventListener('click', () => {
    link.style.width = '320px';
    link.style.height = '107px';
    link.style.backgroundColor = 'white';
    link.style.fontSize = '50px'
    link.style.color = 'black'
    
    let loginEl = document.getElementById('login-box')
    let chefButton = document.createElement('BUTTON');
    let clientButton = document.createElement('BUTTON');

    chefButton.setAttribute('class', 'login-choices')
    clientButton.setAttribute('class', 'login-choices')

    chefButton.innerHTML = 'Chef'
    clientButton.innerHTML = 'Client'

    loginEl.append(chefButton)
    loginEl.append(clientButton)

  }, { once: true })

  const startChefEmailPrompt = () => {
    let emailBox = document.createElement('INPUT');
    let emailBoxLbl = document.createElement('P');

    emailBoxLbl.innerHTML = 'Email'
    emailBoxLbl.setAttribute("id", "login-email-lbl");
    emailBox.setAttribute("type", "text");
    emailBox.setAttribute("id", "email-box");
    loginEl.append(emailBoxLbl)
    loginEl.append(emailBox)
  }
});
