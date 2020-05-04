class Chef::BaseController < ApplicationController
  before_action :authorize

  protected
  
  def authorize
    @chef ||= Chef.find_by(id: session[:chef_id])
    redirect_to root_path unless @chef
  end
end