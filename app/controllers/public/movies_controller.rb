class Public::MoviesController < ApplicationController
    
  def index
    # @movies = Movie.all.page(params[:page]).per(20)
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true).page(params[:page]).per(20)
    if @q_header
      @movies = @q_header.result(distinct: true).page(params[:page]).per(20)
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @movie.increment!(:read_count)
    @review = Review.new
    @reviews = @movie.reviews.includes(:user).where(user: {membership_status: false})
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: 'レビューを投稿しました。'
    else
      redirect_to request.referer
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy
    redirect_to admin_cinema_path(params[:movie_id]), notice: 'レビューを削除しました。'
  end

  private

  def review_params
    params.require(:review).permit(:rate, :body)
  end
  
end