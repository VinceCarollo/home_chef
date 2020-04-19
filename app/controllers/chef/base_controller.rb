class Chef::BaseController < ApplicationController
  before_action :admin_required

  protected
  
  def admin_required
    @chef = Chef.find_by(id: session[:chef_id])
    redirect_to root_path unless @chef
  end
end