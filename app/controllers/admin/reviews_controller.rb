class Admin::ReviewsController < ApplicationController
  before_action :authenticate_user_or_admin!

  def destroy
    @review = Review.find(params[:id])
    redirect_to admin_cinema_path(@review.movie.id), notice: 'レビューを削除しました。'
    @review.destroy
  end

  def authenticate_user_or_admin!
    request.path.start_with?('/admin')
    authenticate_admin!
  end
end
