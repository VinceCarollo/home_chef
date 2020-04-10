class AddTravelDistanceToChefs < ActiveRecord::Migration[6.0]
  def change
    add_column :chefs, :travel_distance, :integer
  end
end
