class ReviewSerializer < ActiveModel::Serializer
  attributes :id,:comment, :rating

  belongs_to :movie
end
