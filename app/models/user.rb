class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :projects
  has_many :tasks
  has_many :comments
  has_one :resume, :dependent => :destroy
  acts_as_voter
  paginates_per 10
end
