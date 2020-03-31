class Address < ApplicationRecord
  belongs_to :chef
  belongs_to :addressable, polymorphic: true
end