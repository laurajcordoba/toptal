class Task < ActiveRecord::Base
  # == Accessors
  attr_accessible :description, :priority, :due_date, :completed, :user_id

  # == Constants
  PRIORITY = %w(HIGH MEDIUM LOW)

  # == Validations
  validates :description, :priority, :due_date, presence: true

  # == Associations
  belongs_to :user
end
