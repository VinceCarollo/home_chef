import newChef from './new_chef';

document.addEventListener('DOMContentLoaded', () => {
  if (Object.keys(document.getElementsByClassName("new-chef-form")).length) {
    newChef();
  }
});