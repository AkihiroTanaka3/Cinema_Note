class Public::UsersController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def edit
  end
end
