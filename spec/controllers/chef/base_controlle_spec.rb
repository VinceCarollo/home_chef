require 'rails_helper'

RSpec.describe Chef::BaseController, type: :controller do
  controller(Chef::BaseController) do
    def index
      head :ok
    end
  end

  describe 'before actions' do
    describe 'authorize' do
      let!(:chef) { FactoryBot.create(:chef) }
      let(:bad_chef_id) { chef.id + 1 }

      it 'authorizes correct credentials' do
        session[:chef_id] = chef.id
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'boots out the unwanted' do
        session[:chef_id] = bad_chef_id
        get :index
        expect(response).to redirect_to('/')
        expect(session[:chef_id]).to be nil
      end
    end
  end
end