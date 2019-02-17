class User < ApplicationRecord
  before_save{ self.email = email.downcase }
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9][a-zA-Z0-9\-_[^\s\W]]{4,}\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, length: { minimum: 4, maximum: 18}, format: { with: VALID_USERNAME_REGEX }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
end
