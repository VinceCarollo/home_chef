class Chef::BaseController < ApplicationController
  before_action :authorize

  protected
  
  def authorize
    @chef ||= Chef.find_by(id: session[:chef_id])
    unless @chef
      session[:chef_id] = nil
      redirect_to root_path
    end
  end
end