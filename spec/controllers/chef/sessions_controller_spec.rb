require 'rails_helper'

RSpec.describe Chef::SessionsController, type: :controller do
  describe 'create' do
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
      expect(response).to redirect_to(:chefs_dashboard)
    end

    it 'will not login with bad email' do
      credentials[:email] = 'invalid_email'

      post :create, params: credentials

      expect(session[:chef_id]).to be nil
      expect(flash[:alert]).to eq('Invalid Login Credentials')
    end

    it 'will not login with bad password' do
      credentials[:password] = 'invalid_password'

      post :create, params: credentials

      expect(session[:chef_id]).to be nil
      expect(flash[:alert]).to eq('Invalid Login Credentials')
    end
  end

  describe 'destroy' do
    before do
      session[:chef_id] = 1234
    end

    it 'destroys session' do
      delete :destroy
      expect(session[:chef_id]).to be nil
    end

    it 'redirects home' do
      delete :destroy
      expect(response).to redirect_to(:root)
    end
  end
end
