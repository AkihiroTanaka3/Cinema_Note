class Public::LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_movie, only: [:create, :destroy]

  def create
    current_user.favorites.create(movie: @movie)
    redirect_to @movie
  end

  def destroy
    current_user.favorites.find_by(movie: @movie).destroy
    redirect_to @movie
  end

  def authenticate_user!
    redirect_to root_path, notice: 'ログインしてください。' unless user_signed_in?
  end
  
  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
