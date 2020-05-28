class ClientsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  def new; end

  def create
    client = Client.new(client_params)
    if client.save
      session[:client_id] = client.id
      head :ok
    else
      render json: client.errors, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name
    )
  end
end
