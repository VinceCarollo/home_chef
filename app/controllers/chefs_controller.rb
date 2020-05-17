class ChefsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :confirm_email]

  def new
    @chef = Chef.new
  end

  def create
    chef = Chef::CreateService.perform(chef_params)
    if chef.errors.present?
      render json: chef.errors, status: :unprocessable_entity
    else
      session[:chef_id] = chef.id
      head :ok
    end
  end

  def update
    if @chef.update(chef_params)
      head :ok
    else
      render json: @chef.errors, status: :unprocessable_entity
    end
  end

  def confirm_email
    chef = Chef.find_by(confirm_token: params[:id])
    if chef
      chef.update(
        confirm_token: nil,
        email_confirmed: true
      )
      session[:chef_id] = chef.id
      flash[:notice] = 'Your Email was Successfully Verified'
      redirect_to chefs_dashboard_path
    else
      redirect_to root_path
    end
  end

  private

  def chef_params
    params.require(:chef).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :age,
      :zip_code,
      :travel_distance,
      :years_of_pro_experience,
      :years_of_am_experience,
      :self_description,
      :specialty,
      :monday,
      :tuesday,
      :wednesday,
      :thursday,
      :friday,
      :saturday,
      :sunday
    )
  end
end