class ChefMailer < ApplicationMailer
  def registration_confirmation
    @chef = params[:chef]
    mail(:to => "#{@chef.first_name} <#{@chef.email}>", :subject => "Registration Confirmation")
    Rails.logger.warn "Registration email sent to #{@chef.email}"
  end
end
