class CreateChefs < ActiveRecord::Migration[6.0]
  def change
    create_table :chefs do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :age
      t.integer :years_of_pro_experience
      t.integer :years_of_am_experience
      t.text :self_description, null: false
      t.text :unavailable

      t.timestamps
    end
  end
end
