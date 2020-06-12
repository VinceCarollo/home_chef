export default function clientDashboard() {
  let findChefsButton = document.getElementsByClassName('find-chefs-button')[0]

  findChefsButton.addEventListener('click', () => {
    window.location.href = '/chefs'
  })
}
