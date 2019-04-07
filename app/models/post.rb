class Post < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	validates :author, presence: true
	belongs_to :user
	has_many :comments
	acts_as_votable
	paginates_per 10
end
