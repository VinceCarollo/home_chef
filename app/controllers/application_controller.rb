class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authorize

  protected

  def authorize
    @chef ||= Chef.find_by_id(session[:chef_id])
    @client ||= Client.find_by_id(session[:client_id])
    if @chef || @client
      unless @chef&.email_confirmed || @client&.email_confirmed
        flash[:alert] = 'You Must Verify Your Email Address to Use All of Our Tools'
      end
    else
      session[:chef_id] = nil
      session[:client_id] = nil
      redirect_to root_path
    end
  end
end
