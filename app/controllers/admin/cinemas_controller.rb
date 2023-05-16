class Admin::CinemasController < ApplicationController
  before_action :authenticate_user_or_admin!

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
  
  def authenticate_user_or_admin!
    request.path.start_with?('/admin')
    authenticate_admin!
  end
end
