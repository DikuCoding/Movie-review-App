require 'net/http'
require 'json'
class MoviesController < ApplicationController
  def index
    @movies = fetch_movies_from_api
    # render json: @movie, status: 200
  end

  def show
    Rails.logger.debug "Params: #{params.inspect}" # Debugging Statements
    @movie = fetch_movie_details(params[:id])
    @review = Review.new

    if !Movie.find_by(tmdb_id: id)
      movie_details = fetch_movie_details(params[:id])

      Movie.create(
        backdrop_path: movie["backdrop_path"]
        original_title: movie["original_title"]
        overview: movie["overview"]
        homepage: movie["homepage"]
        poster_path: movie["poster_path"]
        runtime: movie["runtime"]
        status: movie["status"]
        imdb_id: movie["imdb_id"]
        tmdb_id: movie["tmdb_id"]
        vote_average: movie["vote_average"]
      )
    else
      @movie = Movie.find
    end
    
  end

  def fetch_movies_from_api
    api_key = ENV["TMDB_API_KEY"]
    url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}&language=en-US&page=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)["results"]

  rescue JSON::ParserError => e
    flash[:error] = "Error fetching movies: #{e.message}"
    []
  rescue StandardError => e
    flash[:error] = "Error fetching movies: #{e.message}"
    []  # Return an empty array to prevent nil error
  end

  def fetch_movie_details(movie_id)
    api_key = ENV["TMDB_API_KEY"]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{api_key}&language=en-US&page=1"
    uri = URI(url)

    response = Net::HTTP.get(uri)
    JSON.parse(response)
    rescue StandardError => e
      flash[:error] = "Error fetching movie details: #{e.message}"
      nil
    end

    
end
