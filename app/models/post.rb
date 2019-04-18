class Post < ApplicationRecord
	validates :title, presence: true, length: {maximum: 80}
	validates :content, presence: true, length: {maximum: 800}
	validates :author, presence: true
	belongs_to :user
	has_many :comments
	acts_as_votable
	paginates_per 10
end
