import Rails from '@rails/ujs'
import { showWarning, removeWarning } from '../alerts/index'

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
        let chefId = selfDescBox.getAttribute('data-chef');
        let data = {
          chef: {
            'self_description': editableDesc.value
          }
        }        
        
        $.ajax({
          url: '/chefs/'.concat(chefId),
          type: 'PATCH',
          contentType: 'application/json',
          data: JSON.stringify(data),
          error: async (e) => {
            showWarning(e.responseJSON);
            await new Promise(r => setTimeout(r, 2000));
            removeWarning();
          },
          success: async () => {
            showWarning('Your self description has been updated')
            desc.innerHTML = editableDesc.value;
            desc.style.display = 'block';
            editableDesc.remove();
            saveButton.remove();
            await new Promise(r => setTimeout(r, 2000));
            removeWarning();
            listenForEditPress();
          }
        })
      })

    }, { once: true })
  }

  listenForEditPress();
}

export default chefDashboard