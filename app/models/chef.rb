class Chef < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

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
            length: { minimum: 6, maximum: 20 }, on: :create

  has_one :address, as: :addressable

  delegate :city, :state, :zip, to: :address

  before_create :create_confirmation_token

  private

  def create_confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s unless confirm_token
  end
end