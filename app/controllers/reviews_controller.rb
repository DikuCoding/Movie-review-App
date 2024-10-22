class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)

    if @review.save
      redirect_to movie_path(@review.movie.tmdb_id), notice: 'Review submitted successfully.'
    else
      flash.now[:alert] = "There was a problem submitting your review"
      render 'movies/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :comment, :rating)
  end
end
