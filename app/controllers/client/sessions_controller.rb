class Client::SessionsController < Client::BaseController
  skip_before_action :authorize, only: %i[create new]

  def destroy
    session[:client_id] = nil
    redirect_to root_path
  end

  def create
    client = Client.find_by(email: params[:email])
    if client&.authenticate(params[:password])
      session[:client_id] = client.id
      redirect_to clients_dashboard_path
    else
      flash[:alert] = 'Invalid Login Credentials'
      render :new
    end
  end

  def new; end
end
