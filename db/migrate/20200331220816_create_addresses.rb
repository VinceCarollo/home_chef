class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end
end
