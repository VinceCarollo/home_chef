import showMsg from '../messages/index'

const chefDashboard = () => {
  let descEditButton = document.getElementById('self_desc_edit_button');
  let selfDescBox = document.getElementById('chef-self-desc')

  const listenForEditPress = () => {
    descEditButton.addEventListener('click', () => {
      let desc = document.getElementById('chef-self-description');
      let editableDesc = document.createElement('TEXTAREA');
      let saveButton = document.createElement('BUTTON')
  
      saveButton.setAttribute('type', 'submit')
      saveButton.innerHTML = 'Save'
  
      editableDesc.value = desc.textContent;
      desc.style.display = 'none'
      selfDescBox.insertBefore(editableDesc, descEditButton)
      selfDescBox.insertBefore(saveButton, descEditButton)

      saveButton.addEventListener('click', () => {
        var AUTH_TOKEN = encodeURIComponent($('meta[name=csrf-token]').attr('content'));
        let chefId = selfDescBox.getAttribute('data-chef');
        let data = {
          chef: {
            'self_description': editableDesc.value
          }
        }        
        
        $.ajax({
          url: '/chefs/'.concat(chefId) + "?&authenticity_token=" + AUTH_TOKEN,
          type: 'PATCH',
          contentType: 'application/json',
          data: JSON.stringify(data),
          error: (e) => {
            showMsg(e.responseJSON);
          },
          success: () => {
            showMsg('Your Self Description Has Been Updated', 'success')
            desc.innerHTML = editableDesc.value;
            desc.style.display = 'block';
            editableDesc.remove();
            saveButton.remove();
            listenForEditPress();
          }
        })
      })

    }, { once: true })
  }

  listenForEditPress();
}

export default chefDashboard