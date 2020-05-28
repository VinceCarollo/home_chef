require 'rails_helper'

RSpec.describe Chef::SessionsController, type: :controller do
  describe 'logging in' do
    let!(:chef) do
      FactoryBot.create(
        :chef,
        email: 'test@example.com',
        password: 'password'
      )
    end
    let(:credentials) do
      {
        email: chef.email,
        password: chef.password
      }
    end

    it 'logs chefs in and redirects to dashboard' do
      post :create, params: credentials
      expect(session[:chef_id]).to eq(chef.id)
      expect(response).to have_http_status(:ok)
    end

    it 'will not login with bad email' do
      credentials[:email] = 'invalid_email'

      post :create, params: credentials

      expect(session[:chef_id]).to be nil
      expect(response).to have_http_status(:unauthorized)

      error = JSON.parse(response.body)

      expect(error).to have_key('invalid')
      expect(error['invalid']).to eq('login - please try again')
    end

    it 'will not login with bad password' do
      credentials[:password] = 'invalid_password'

      post :create, params: credentials

      expect(response).to have_http_status(:unauthorized)

      error = JSON.parse(response.body)

      expect(error).to have_key('invalid')
      expect(error['invalid']).to eq('login - please try again')
    end
  end
end
