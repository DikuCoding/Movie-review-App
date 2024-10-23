class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)

    if @review.save
      respond_to do |format|
        format.html {redirect_to movie_path(@review.movie.tmdb_id), notice: 'Review submitted successfully.'}
        format.turbo_stream
      end
    else
      flash.now[:alert] = "There was a problem submitting your review"
      render 'movies/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to movie_path(@review.movie.tmdb_id), notice: "Review was sucessfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :comment, :rating)
  end
end
