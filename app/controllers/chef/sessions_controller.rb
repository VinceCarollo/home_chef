class Chef::SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def destroy
    session[:chef_id] = nil
    redirect_to root_path
  end

  def create
    chef = Chef.find_by(email: params[:email])
    if chef&.authenticate(params[:password])
      session[:chef_id] = chef.id
      head :ok
    else
      render json: { invalid: 'login - please try again'}, status: 401
    end
  end
end