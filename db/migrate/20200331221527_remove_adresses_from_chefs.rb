class RemoveAdressesFromChefs < ActiveRecord::Migration[6.0]
  def up
    remove_column :chefs, :street
    remove_column :chefs, :city
    remove_column :chefs, :state
    remove_column :chefs, :zip
  end

  def down
    add_column :chefs, :street
    add_column :chefs, :city
    add_column :chefs, :state
    add_column :chefs, :zip
  end
end
