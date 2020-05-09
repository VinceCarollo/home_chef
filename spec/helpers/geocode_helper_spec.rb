require 'rails_helper'

RSpec.describe GeocodeHelper, type: :helper do
  describe 'get_geo_response_from_zip' do
    let(:ls_zipcode) { '64086' }

    it 'returns response from zip' do
      VCR.use_cassette("geocode/lees_summit_zip") do
        response = helper.get_geo_response_from_zip(ls_zipcode)
        expect(response.city).to eq('Lees Summit')
        expect(response.state).to eq('MO')
        expect(response.zip).to eq('64086')
      end
    end
  end
end