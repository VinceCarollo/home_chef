class WelcomeController < ApplicationController
  skip_before_action :authorize, only: :index

  def index
    return unless session[:chef_id]
    @chef = Chef.find_by(id: session[:chef_id])
    if @chef
      redirect_to chefs_dashboard_path
    end
  end
end