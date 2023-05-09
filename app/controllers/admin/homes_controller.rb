class Admin::HomesController < ApplicationController

  def top
     @movies = Movie.all
  end
  
end
