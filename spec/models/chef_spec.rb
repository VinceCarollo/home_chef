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

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:self_description) }
    it { should validate_presence_of(:specialty) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }
  end

  describe 'associations' do
    it { should have_one(:address) }
  end
end
