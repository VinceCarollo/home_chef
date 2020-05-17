class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_action :authorize

  protected
  
  def authorize
    @chef ||= Chef.find_by(id: session[:chef_id])
    unless @chef
      session[:chef_id] = nil
      redirect_to root_path
    else
      flash[:alert] = "You Must Verify Your Email Address to Use All of Our Tools" unless @chef.email_confirmed
    end
  end
end
