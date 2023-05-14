class Public::LikesController < ApplicationController
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
end
