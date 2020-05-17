require 'rails_helper'

RSpec.describe ChefsController, type: :controller do
  describe 'create' do
    let(:chef) { double(Chef, id: 13, errors: nil) }

    before do
      allow(Chef::CreateService).to receive(:perform)
        .and_return(chef)
    end

    describe 'successfull' do
      it 'returns ok' do
        post :create, params: { chef: { fake: 'params' } }
        expect(response).to have_http_status(:ok)
      end

      it 'changes session' do
        post :create, params: { chef: { fake: 'params' } }
        expect(session[:chef_id]).to eq(chef.id)
      end
    end

    describe 'unsuccessful' do
      before do
        allow(chef).to receive(:errors)
          .and_return({ password: ['is too short'] })
      end

      it 'returns unprocessable' do
        post :create, params: { chef: { fake: 'params' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders errors' do
        post :create, params: { chef: { fake: 'params' } }
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error).to have_key(:password)
        expect(error[:password]).to include('is too short')
      end
    end
  end
end