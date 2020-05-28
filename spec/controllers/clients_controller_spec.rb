require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe 'create' do
    let(:params) do
      {
        client: {
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'vince',
          last_name: 'test'
        }
      }
    end

    describe 'successful' do
      it 'creates chef' do
        post :create, params: params, as: :json

        client_params = params[:client]
        client = Client.last

        expect(client.email).to eq(client_params[:email])
        expect(client.first_name).to eq(client_params[:first_name])
        expect(client.last_name).to eq(client_params[:last_name])
      end

      it 'adds to session' do
        post :create, params: params, as: :json
        expect(session[:client_id]).to eq(Client.last.id)
      end

      it 'returns ok' do
        post :create, params: params, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'unsuccessful' do
      before do
        params[:client][:password_confirmation] = 'non_matching'
      end

      it 'returns client errors' do
        post :create, params: params, as: :json

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:password_confirmation)
        expect(error[:password_confirmation])
        expect(error[:password_confirmation]).to include("doesn't match Password")
      end

      it 'returns unprocessable' do
        post :create, params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
