class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies, status: 200
  end

  def create
    movie = Movies.new(
      backdrop_path: prod_params[:backdrop_path],
      original_title: prod_params[:original_title],
      overview: prod_params[:overview],
      homepage: prod_params[:homepage],
      poster_path: prod_params[:poster_path],
      runtime: prod_params[:runtime],
      status: prod_params[:status],
      imdb_id: prod_params[:imdb_id],
      tmdb_id: prod_params[:tmdb_id],
      vote_average: prod_params[:vote_average],
    )
    if movie.save
      render json: movie, status: 200
    else
      render json: {error: "Movies not found"}
    end
  end

  def show
    movie = Movie.find_by(params[:id])
    if movie
      render json: {
      "movie": MovieSerializer.new(movie)
    }
    else
      render json: {error: "Movie not found"}
    end
  end
  

  private
    def prod_params
      params.require[:movies].permit([
        :backdrop_path,
        :original_title,
        :overview,
        :homepage,
        :poster_path,
        :runtime,
        :status,
        :imdb_id,
        :tmdb_id,
        :vote_average,
      ])
    end
  
end
