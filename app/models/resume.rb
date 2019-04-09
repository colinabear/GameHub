class Resume < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true
  validates :phone_number, presence: true
  validates :biography, presence: true
  belongs_to :user
end
