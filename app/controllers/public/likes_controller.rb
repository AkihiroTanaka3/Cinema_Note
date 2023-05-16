class Public::LikesController < ApplicationController
    before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    current_user.favorites.create(movie: @movie)
    redirect_to @movie
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    current_user.favorites.find_by(movie: @movie).destroy
    redirect_to @movie
  end

  def authenticate_user!
    redirect_to root_path, notice: 'ログインしてください。' unless user_signed_in?
  end
end
