class Chef::CreateService
  include Chef::UnavailabilityHelper
  include GeocodeHelper

  def self.perform(params)
    new(params).create_chef
  end

  def initialize(params)
    @params = params
    @chef = Chef.create(chef_create_params)
  end

  def create_chef
    create_unavailability(@chef) unless creation_errors?
    create_address(@chef) unless creation_errors?
    ChefMailer.with(chef: @chef).registration_confirmation.deliver_now unless creation_errors?
    @chef
  end

  private

  def creation_errors?
    @chef.errors.present?
  end

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
      chef.errors.add(:address, :invalid, message: 'is invalid')
    end
  end

  def create_unavailability(chef)
    chef.update(unavailable: unavail_string_generator(@params))
  end
end
