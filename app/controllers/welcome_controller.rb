class WelcomeController < ApplicationController
  skip_before_action :authorize, only: :index

  def index
    return unless session[:chef_id] || session[:client_id]

    @chef = Chef.find_by_id(session[:chef_id])
    @client = Client.find_by_id(session[:client_id])
    if @chef
      redirect_to chefs_dashboard_path
    elsif @client
      redirect_to clients_dashboard_path
    end
  end
end
