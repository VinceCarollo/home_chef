require 'rails_helper'

RSpec.describe ChefsController, type: :controller do
  describe 'confirm_email' do
    let!(:chef) { FactoryBot.create(:chef) }
    let!(:bad_token) { 'XXxBadTokenxXX' }

    describe 'successful' do
      before do
        get :confirm_email, params: { id: chef.confirm_token }
      end

      it 'updates the chef' do
        chef.reload
        expect(chef.confirm_token).to be nil
        expect(chef.email_confirmed).to be true
      end

      it 'sets the session' do
        expect(session).to have_key(:chef_id)
        expect(session[:chef_id]).to eq(chef.id)
      end

      it 'adds flash notice' do
        expect(flash[:notice]).to eq('Your Email was Successfully Verified')
      end

      it 'redirects to dashboard' do
        expect(response).to redirect_to(chefs_dashboard_path)
      end
    end

    describe 'unsuccessful' do
      before do
        get :confirm_email, params: { id: bad_token }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'update' do
    let!(:chef) { FactoryBot.create(:chef) }

    before do
      session[:chef_id] = chef.id
    end

    describe 'successful' do
      let(:params) { { email: 'new_email@test.com' } }

      before do
        put :update, params: { id: chef.id, chef: params }
        chef.reload
      end

      it 'returns ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates chef' do
        expect(chef.email).to eq(params[:email])
      end
    end

    describe 'unsuccessful' do
      let(:params) { { email: 'invalid_email' } }

      before do
        put :update, params: { id: chef.id, chef: params }
        chef.reload
      end

      it 'returns unprocessable' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders errors' do
        errors = JSON.parse(response.body, symbolize_names: true)
        expect(errors).to have_key(:email)
        expect(errors[:email]).to include('is invalid')
      end
    end
  end

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
