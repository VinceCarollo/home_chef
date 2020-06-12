import newClient from './client/new_client';
import newChef from './chef/new_chef';
import chefDashboard from './chef/dashboard'

document.addEventListener('DOMContentLoaded', () => {
  if (Object.keys(document.getElementsByClassName("new-client-form-container")).length) {
    newClient();
  }else if (Object.keys(document.getElementsByClassName("new-chef-form-container")).length) {
    newChef();
  } else if (document.getElementById('chef-dashboard')) {
    chefDashboard();
  }
});