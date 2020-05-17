module ApplicationHelper
  def toastr_flash
    # binding.pry
    flash.each_with_object([]) do |(type, message), flash_messages|
      toastr_type = 'success' if type == 'notice'
      toastr_type = 'warning' if type == 'alert'
      text = "<script>toastr.#{toastr_type}('#{message}')</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end
end
