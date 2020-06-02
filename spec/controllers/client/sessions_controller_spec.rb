require 'rails_helper'

RSpec.describe Client::SessionsController, type: :controller do
  describe 'logging in' do
    let!(:client) do
      FactoryBot.create(
        :client,
        email: 'test@example.com',
        password: 'password'
      )
    end
    let(:credentials) do
      {
        email: client.email,
        password: client.password
      }
    end

    it 'logs clients in and redirects to dashboard' do
      post :create, params: credentials
      expect(session[:client_id]).to eq(client.id)
      expect(response).to redirect_to(:clients_dashboard)
    end

    it 'will not login with bad email' do
      credentials[:email] = 'invalid_email'

      post :create, params: credentials

      expect(session[:client_id]).to be nil
      expect(flash[:alert]).to eq('Invalid Login Credentials')
    end

    it 'will not login with bad password' do
      credentials[:password] = 'invalid_password'

      post :create, params: credentials

      expect(session[:client_id]).to be nil
      expect(flash[:alert]).to eq('Invalid Login Credentials')
    end
  end
end
