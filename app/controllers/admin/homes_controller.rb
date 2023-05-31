class Admin::HomesController < ApplicationController
  before_action :authenticate_user_or_admin!
  
  # ランサックの記述を追加
  def top
    @movies = Movie.all.page(params[:page]).per(20)
      @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
    if @q_header
      @movies = @q_header.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
    end
  end
  
  def authenticate_user_or_admin!
    request.path.start_with?('/admin')
    authenticate_admin!
  end
end
