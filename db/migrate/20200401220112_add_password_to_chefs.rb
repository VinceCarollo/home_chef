class AddPasswordToChefs < ActiveRecord::Migration[6.0]
  def change
    add_column :chefs, :password_digest, :string, null: false
  end
end
