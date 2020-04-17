class ChefsController < ApplicationController
  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef::CreateService.perform(chef_params)
    respond_to do |format|
      if @chef.errors.present?
        format.json { render json: @chef.errors, status: :unprocessable_entity }
      else
        format.json { head :ok }
      end
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
      :zip,
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