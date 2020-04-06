class AddSpecailtyToChefs < ActiveRecord::Migration[6.0]
  def change
    add_column :chefs, :specialty, :string, null: false
  end
end
