import showMsg from '../messages/index'

const chefDashboard = () => {
  let descEditButton = document.getElementById('self_desc_edit_button');
  let selfDescBox = document.getElementById('chef-self-desc');
  
  const listenForAvatarUploadPress = () => {
    let avatarModalButton = document.getElementsByClassName('avatar-modal-button')[0];
    let modal = document.getElementsByClassName("modal")[0];
    
    avatarModalButton.addEventListener('click', () => {
      modal.style.display = 'block';
      
      let closeButton = document.getElementsByClassName("close")[0];
      let fileInput = document.getElementById('avatar-input');

      fileInput.addEventListener('change', () => {
        if ( fileInput.files && fileInput.files[0]) {
          let reader = new FileReader();
          let preview = document.getElementById('avatar-preview');
          let saveButton = document.createElement('BUTTON');

          saveButton.innerHTML = 'Save';
          saveButton.setAttribute('class', 'avatar-save-button')

          preview.style.display = 'block';

          reader.onload = function (e) {
            preview.setAttribute('src', e.target.result);
          }

          let modalContent = document.getElementsByClassName('modal-content')[0]

          console.log(document.getElementsByClassName('avatar-save-button').length);
          
          if (document.getElementsByClassName('avatar-save-button').length === 0) {
            modalContent.append(saveButton)
          }

          reader.readAsDataURL(fileInput.files[0]);
        }
      })

      window.onclick = function (event) {
        if (event.target == modal) {
          modal.style.display = "none";
        }
      }

      closeButton.addEventListener('click', () => {
        modal.style.display = "none";
      })
    })
  }

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
  listenForAvatarUploadPress();
}

export default chefDashboard