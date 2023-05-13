class Admin::CinemasController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    @review = Review.new
    @reviews = @movie.reviews.includes(:user).where(user: {membership_status: false})
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to admin_root_path, notice: '映画を削除しました。'
  end
end
