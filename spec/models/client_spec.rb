require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }
  end

  describe 'delegations' do
    describe 'address' do
      let!(:address) { FactoryBot.create(:address) }
      let!(:client) { FactoryBot.create(:client, address: address) }

      it 'city' do
        expect(client.city).to eq(address.city)
      end

      it 'state' do
        expect(client.state).to eq(address.state)
      end

      it 'zip' do
        expect(client.zip).to eq(address.zip)
      end
    end
  end

  describe 'callbacks' do
    describe 'create_confirmation_token' do
      let!(:client) { FactoryBot.build(:client) }
      
      it 'creates token before create' do
        expect { client.save }.to change { client.confirm_token }.from(nil)
      end
    end
  end
end