class Address < ApplicationRecord
  belongs_to :chef, optional: true
  belongs_to :addressable, polymorphic: true, optional: true
end
