require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe 'validations' do
    let(:chef) { FactoryBot.build(:chef) }

    it 'email' do
      expect(chef.update(email: 'valid@valid')).to be true
      expect(chef.update(email: 'notvalid.com')).to be false
      expect(chef.update(email: 'notvalid@@google.com')).to be false
      expect(chef.update(email: nil)).to be false
      expect(chef.update(email: '')).to be false
    end

    it 'first_name' do
      expect(chef.update(first_name: '')).to be false
      expect(chef.update(first_name: nil)).to be false
    end
    
    it 'last_name' do
      expect(chef.update(last_name: '')).to be false
      expect(chef.update(last_name: nil)).to be false
    end

    it 'self_description' do
      expect(chef.update(self_description: '')).to be false
      expect(chef.update(self_description: nil)).to be false
    end
  end

  describe 'associations' do
    it { should have_one(:address) }
  end
end