class MovieSerializer < ActiveModel::Serializer
  attributes :id, :backdrop_path, :original_title, :overview, :homepage, :poster_path, :runtime, :status, :imdb_id, :tmdb_id, :vote_average

  has_many :reviews
end
