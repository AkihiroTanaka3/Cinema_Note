class Admin::HomesController < ApplicationController

  def top
    @movies = Movie.all.page(params[:page]).per(20)
  end
  
end
