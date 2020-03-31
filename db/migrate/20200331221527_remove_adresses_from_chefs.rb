class RemoveAdressesFromChefs < ActiveRecord::Migration[6.0]
  def up
    remove_column :chefs, :street
    remove_column :chefs, :city
    remove_column :chefs, :state
    remove_column :chefs, :zip
  end

  def down
    add_column :chefs, :street, :string
    add_column :chefs, :city, :string
    add_column :chefs, :state, :string
    add_column :chefs, :zip, :string
  end
end
