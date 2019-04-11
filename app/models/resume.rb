class Resume < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true
  validates :phone_number, presence: true
  validates :biography, presence: true
  validates :avatar, presence: true
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
end
