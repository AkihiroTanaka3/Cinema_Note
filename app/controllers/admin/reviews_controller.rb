class Admin::ReviewsController < ApplicationController

  def destroy
    @review = Review.find(params[:id])
    redirect_to admin_cinema_path(@review.movie.id), notice: 'レビューを削除しました。'
    @review.destroy
  end
end
