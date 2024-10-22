require 'net/http'
require 'json'
class MoviesController < ApplicationController
  def index
    @movies = fetch_movies_from_api
    # render json: @movie, status: 200
  end

  # def show
  #   Rails.logger.debug "Params: #{params.inspect}" # Debugging Statements
  #   @movie = fetch_movie_details(params[:id])
  #   @review = Review.new 
  #   @reviews = @movie.reviews.order(created_at: :desc) # Load reviews 
  #   # Find or create the movie by its tmdb_id (the ID from the API)
  #   @movie = Movie.find_by(tmdb_id: params[:id])

  #   # Check if the movie already exists in the database using tmdb_id
  #   existing_movie = Movie.find_by(tmdb_id: params[:id])
  #   if existing_movie
  #     # If the movie already exists, fetch it from the database
  #     @movie = existing_movie
  #   else
  #     # If the movie doesn't exist, fetch details from the API and save to the database
  #     movie_details = fetch_movie_details(params[:id])

  #     if movie_details.present?
  #       @movie = Movie.create(
  #         backdrop_path: movie_details["backdrop_path"],
  #         original_title: movie_details["original_title"],
  #         overview: movie_details["overview"],
  #         homepage: movie_details["homepage"],
  #         poster_path: movie_details["poster_path"],
  #         runtime: movie_details["runtime"],
  #         status: movie_details["status"],
  #         imdb_id: movie_details["imdb_id"],
  #         tmdb_id: movie_details["id"], # tmdb_id is stored as movie['id']
  #         vote_average: movie_details["vote_average"]
  #       )
  #     else
  #       flash[:error] = "Movie details could not be fetched."
  #       redirect_to movies_path and return 
  #     end
  #   end

  # end
  def show
    Rails.logger.debug "Params: #{params.inspect}" # Debugging Statements
    # Check if the movie exists in the database using tmdb_id
    @movie = Movie.find_by(tmdb_id: params[:id])
    
    # If the movie doesn't exist in the database, fetch details from the API and save it
    if @movie.nil?
      movie_details = fetch_movie_details(params[:id])
      if movie_details.present?
        @movie = Movie.create(
          backdrop_path: movie_details["backdrop_path"],
          original_title: movie_details["original_title"],
          overview: movie_details["overview"],
          homepage: movie_details["homepage"],
          poster_path: movie_details["poster_path"],
          runtime: movie_details["runtime"],
          status: movie_details["status"],
          imdb_id: movie_details["imdb_id"],
          tmdb_id: movie_details["id"], # tmdb_id is stored as movie['id']
          vote_average: movie_details["vote_average"]
        )
      else
        flash[:error] = "Movie details could not be fetched."
        redirect_to movies_path and return
      end
    end
  
    # Create a new Review object for the form
    @review = Review.new
  
    # Load reviews associated with the movie from the database
    @reviews = @movie.reviews.order(created_at: :desc)
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
