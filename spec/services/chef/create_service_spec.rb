require 'rails_helper'

RSpec.describe Chef::CreateService, type: :service do
  describe 'creating a chef' do
    let(:params) do
      {
        email: 'vince@test.com',
        first_name: 'vince',
        last_name: 'carollo',
        password: 'password',
        password_confirmation: 'password',
        years_of_pro_experience: '2',
        years_of_am_experience: '2',
        age: '20',
        specialty: 'chinese',
        self_description: 'self description test',
        zip_code: '64086',
        travel_distance: '13',
        monday: '1',
        tuesday: '1',
        wednesday: '1',
        thursday: '1',
        friday: '1',
        saturday: '0',
        sunday: '0'
      }
    end

    let(:perform) { described_class.perform(params) }

    it 'creates a chef' do
      VCR.use_cassette('geocode/lees_summit_zip') do
        expect { perform }.to change { Chef.count }.from(0).to(1)
      end

      chef = Chef.last

      expect(chef.email).to eq(params[:email])
      expect(chef.first_name).to eq(params[:first_name])
      expect(chef.last_name).to eq(params[:last_name])
      expect(chef.years_of_pro_experience).to eq(params[:years_of_pro_experience].to_i)
      expect(chef.years_of_am_experience).to eq(params[:years_of_am_experience].to_i)
      expect(chef.age).to eq(params[:age].to_i)
      expect(chef.specialty).to eq(params[:specialty])
      expect(chef.self_description).to eq(params[:self_description])
      expect(chef.zip).to eq(params[:zip_code])
      expect(chef.travel_distance).to eq(params[:travel_distance].to_i)
      expect(chef.unavailable).to eq('sun, sat')
    end

    describe 'address' do
      let(:correct_address) do
        {
          city: 'Lees Summit',
          state: 'MO',
          zip: '64086'
        }
      end

      it 'updates chefs address' do
        VCR.use_cassette('geocode/lees_summit_zip') do
          perform
        end
        chef = Chef.last
        expect(chef.city).to eq(correct_address[:city])
        expect(chef.state).to eq(correct_address[:state])
        expect(chef.zip).to eq(correct_address[:zip])
      end

      it 'adds error with bad zip' do
        params[:zip_code] = '4d55f'

        VCR.use_cassette('geocode/invalid_zip_4d55f') do
          chef = perform
          expect(chef.errors).to have_key(:address)
          expect(chef.errors[:address]).to include('is invalid')
        end
      end
    end

    describe 'registration email' do
      it 'successfully sends' do
        VCR.use_cassette('geocode/lees_summit_zip') do
          expect { perform }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1)
        end
      end

      it 'does not send on error' do
        VCR.use_cassette('geocode/lees_summit_zip') do
          params[:password_confirmation] = 'non matching'
          expect { perform }.to_not change { ActionMailer::Base.deliveries.count }
        end
      end
    end
  end
end
