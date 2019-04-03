class Project < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :progress, presence: true
  belongs_to :user
  has_many :comments
  has_many :tasks
  acts_as_votable
end
