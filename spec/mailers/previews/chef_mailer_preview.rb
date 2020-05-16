class ChefMailerPreview < ActionMailer::Preview
  def registration_confirmation
    ChefMailer.with(chef: Chef.where.not(confirm_token: nil).first).registration_confirmation
  end
end