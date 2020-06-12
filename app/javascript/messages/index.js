export default function showMsg(msg, type) {
  if (typeof msg === 'object') {
    // For resource errors
    Object.entries(msg).forEach((error) => {
      let formattedError = (error[0] + ' ' + error[1][0]).replace('_', ' ')
      toastr.warning(formattedError)
    })
  } else {
    if (type === 'warning') {
      toastr.warning(msg);
    } else if (type === 'error') {
      toastr.error(msg);
    } else if (type === 'success') {
      toastr.success(msg);
    }
  }
}
