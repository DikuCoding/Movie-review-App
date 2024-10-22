class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user  # Assuming you have a user model for authentication
  # validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  # validates :comment, presence: true
end
