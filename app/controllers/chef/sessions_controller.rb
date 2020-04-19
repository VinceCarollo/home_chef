class Chef::SessionsController < ApplicationController
  def destroy
    session[:chef_id] = nil
    redirect_to root_path
  end
end