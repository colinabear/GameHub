class Resume < ApplicationRecord
  belongs_to :user
  has_one :name
  has_one :phone_number
  has_one :location
end
