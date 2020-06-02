class Chef::SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[create new]

  def destroy
    session[:chef_id] = nil
    redirect_to root_path
  end

  def create
    chef = Chef.find_by(email: params[:email])
    if chef&.authenticate(params[:password])
      session[:chef_id] = chef.id
      redirect_to chefs_dashboard_path
    else
      flash[:alert] = 'Invalid Login Credentials'
      render :new
    end
  end

  def new; end
end
