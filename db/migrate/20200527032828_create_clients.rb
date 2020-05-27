class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :email_confirmed, default: false, null: false
      t.string :confirm_token

      t.timestamps
    end
  end
end
