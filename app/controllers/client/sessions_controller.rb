class Client::SessionsController < Client::BaseController
  def destroy
    session[:client_id] = nil
    redirect_to root_path
  end
end
