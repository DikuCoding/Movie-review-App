class Review < ApplicationRecord
  belongs_to :movie

  validates :user_id, :comment, :rating, presence: true
end
