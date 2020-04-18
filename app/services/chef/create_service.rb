class Chef::CreateService
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
    @params.except(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :zip)
  end

  def create_address(chef)
    geo_address = Geocodio::Client.new.geocode(@params[:zip]).first&.first if @params[:zip].length == 5
    if geo_address  
      address = Address.create_or_find_by(city: geo_address.city, state: geo_address.state, zip: geo_address.zip)
      chef.address = address
    else
      chef.errors.add(:address, :invalid, message: "is invalid")
    end
    chef  
  end

  def create_unavailability(chef)
    # Creates strings from form checkboxes 
    # chef.unavailable = 'mon, tue, wed'
    unaval = Date::DAYNAMES.map(&:downcase).map do |day|
      day[0..2] if @params[day.to_sym] == '0'
    end.compact.join(' ')

    chef.unavailable = unaval
    chef
  end
end