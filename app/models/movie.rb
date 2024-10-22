class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  # validates :tmdb_id, uniqueness: true
  
  # def create_movie_from_api(movie_data)
  #   Movie.create(
  #     backdrop_path: movie_data["backdrop_path"]
  #     original_title: movie_data["original_title"],
  #     overview: movie_data["overview"],
  #     homepage: movie_data["homepage"],
  #     tmdb_id: movie_data["id"],
  #     poster_url: "https://image.tmdb.org/t/p/w500#{movie_data["poster_path"]}"
  #   )
  # end
  
end
