import newChef from './new_chef';
import chefDashboard from './dashboard'

document.addEventListener('DOMContentLoaded', () => {
  if (Object.keys(document.getElementsByClassName("new-chef-form-container")).length) {
    newChef();
  } else if (document.getElementById('chef-dashboard')) {
    chefDashboard();
  }
});