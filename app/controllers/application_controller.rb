class ApplicationController < ActionController::Base
  before_action :set_q_for_movie

   
  def set_q_for_movie
    @q_header = Movie.ransack(params[:q])
  end
  
  def after_sign_in_path_for(resource) 
    movies_path
  end
end
