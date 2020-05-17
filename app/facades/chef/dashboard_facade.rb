class Chef::DashboardFacade
  include Chef::UnavailabilityHelper

  def initialize(chef)
    @chef = chef
  end

  def id
    @chef.id
  end

  def email
    @chef.email.capitalize
  end

  def specialty
    @chef.specialty.capitalize
  end

  def city
    @chef.city
  end

  def state
    @chef.state
  end

  def zip
    @chef.zip
  end

  def has_photo?
    @chef.pro_pic.attachment
  end

  def profile_pic
    @chef.pro_pic
  end

  def self_description
    @chef.self_description
  end

  def unavailable
    return 'None' if @chef.unavailable.nil?
    unavail_to_readable(@chef.unavailable)
  end
end