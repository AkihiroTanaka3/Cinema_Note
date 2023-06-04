class Public::MoviesController < ApplicationController
    before_action :authenticate_user!
    before_action :destroy_review_user, only: [:destroy]

  def index
    # ランサックの記述を追加
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
    if @q_header
      @movies = @q_header.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @movie.increment!(:read_count)
    @review = Review.new
    @reviews = @movie.reviews.includes(:user).where(user: {membership_status: false}).order(created_at: :desc)
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      @reviews = @movie.reviews.includes(:user).where(user: {membership_status: false}).order(created_at: :desc)
      flash[:notice] = 'レビューを投稿しました。'
      render 'reviews_form.js'
    else
      redirect_to request.referer, alert: "空欄を入力してください"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy
    redirect_to movie_path(params[:movie_id]), notice: 'レビューを削除しました。'
  end

  private

  def review_params
    params.require(:review).permit(:rate, :body)
  end

  def authenticate_user!
    redirect_to root_path, notice: 'ログインしてください。' unless user_signed_in?
  end
  
  def destroy_review_user
    review = Review.find(params[:review_id])
    
    if review.user_id != current_user.id
      redirect_to root_path, alert: '他の人のレビューは削除できません。'
    end
  end

end