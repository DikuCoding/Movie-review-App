class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    @review.user = current_user  # Assuming you have user authentication

    if @review.save
      redirect_to @movie, notice: 'Review was successfully created.'
    else
      @reviews = @movie.reviews
      render 'movies/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
