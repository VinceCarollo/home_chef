import newClient from './new_client';

document.addEventListener('DOMContentLoaded', () => {
  if (Object.keys(document.getElementsByClassName("new-client-form-container")).length) {
    newClient();
  }
});