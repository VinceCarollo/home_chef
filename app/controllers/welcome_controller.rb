class WelcomeController < ApplicationController
  def index
    @chef = Chef.find_by(id: session[:chef_id])
    if @chef
      redirect_to chefs_dashboard_path
    end
  end
end