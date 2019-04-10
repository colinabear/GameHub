class Task < ApplicationRecord
  validates :title, presence: true, length: {maximum: 80}
  validates :description, presence: true, length: {maximum: 800}
  validates :status, presence: true
  validates :user_id, presence: true
  validates :job_type, presence: true
  belongs_to :project
  belongs_to :user
  serialize :pending_users, Array
  paginates_per 10
end
