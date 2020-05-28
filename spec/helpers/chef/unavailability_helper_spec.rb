require 'rails_helper'

RSpec.describe Chef::UnavailabilityHelper, type: :helper do
  describe 'unavail_string_generator' do
    let(:form_input) do
      {
        'monday': '1',
        'tuesday': '1',
        'wednesday': '1',
        'thursday': '1',
        'friday': '1',
        'saturday': '0', # Unavailable
        'sunday': '0' # Unavailable
      }
    end

    it 'turns form input into chef unavailable string' do
      expect(helper.unavail_string_generator(form_input))
        .to eq('sun, sat')
    end
  end

  describe 'unavail_to_readable' do
    let(:chef_unavail) { 'sun, sat' }

    it 'turns chef unavail attribute to readable string' do
      expect(helper.unavail_to_readable(chef_unavail))
        .to eq('Sunday, Saturday')
    end
  end
end
