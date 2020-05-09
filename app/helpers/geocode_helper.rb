module GeocodeHelper
  def get_geo_response_from_zip(zip)
    return unless zip.length == 5
    Geocodio::Client.new.geocode(zip).first.first
  end
end