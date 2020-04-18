class Chef::BaseController < ApplicationController
  before_action :authenticate

  def authenticate
    @chef = Chef.find_by(id: session[:chef_id])
    redirect_to '/' unless @chef
  end
end