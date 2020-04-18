class Chef < ApplicationRecord
  has_secure_password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, 
            presence: true, 
            empty: false

  validates :first_name,
            :last_name,
            :self_description,
            :specialty,
            empty: false, 
            presence: true

  validates :password, 
            length: { minimum: 6, maximum: 20 }

  has_one :address, as: :addressable
end