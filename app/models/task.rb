class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  validates :job_type, presence: true
  belongs_to :project
  belongs_to :user
  serialize :pending_users, Array
end
