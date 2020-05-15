class Chef::CreateService
  include Chef::UnavailabilityHelper
  include GeocodeHelper

  def self.perform(params)
    new(params).create_chef
  end

  def initialize(params)
    @params = params
  end

  def create_chef
    chef = Chef.create(chef_create_params)
    chef = create_unavailability(chef)
    chef = create_address(chef) unless chef.errors.present?
    chef
  end

  private

  def chef_create_params
    @params.except(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :zip_code)
  end

  def create_address(chef)
    geo_response = get_geo_response_from_zip(@params[:zip_code])

    if geo_response
      chef.update(
        address: Address.create_or_find_by(city: geo_response.city, state: geo_response.state, zip: geo_response.zip, street: nil)
      )
    else
      chef.errors.add(:address, :invalid, message: "is invalid")
    end
    chef  
  end

  def create_unavailability(chef)
    weekday_choices = @params.select{|par, _val| Date::DAYNAMES.map(&:downcase).include?(par.to_s) }
    unavailable = unavail_string_generator(weekday_choices)
    chef.update(unavailable: unavailable)
    chef
  end
end