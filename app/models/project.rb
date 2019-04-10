class Project < ApplicationRecord
  validates :name, presence: true, length: {maximum: 60}
  validates :description, presence: true, length: {maximum: 800}
  validates :author, presence: false
  validates :progress, presence: true
  belongs_to :user
  has_many :comments
  has_many :tasks
  acts_as_votable
  paginates_per 10
  serialize :team_members, Array
end
