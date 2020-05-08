class Chef::DashboardController < Chef::BaseController
  def show
    render locals: {
      facade: Chef::DashboardFacade.new(@chef)
    }
  end
end