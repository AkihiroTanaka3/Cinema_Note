class Public::HomesController < ApplicationController
    before_action :authenticate_user!, except: [:top, :about]
    
  def top
  end
  def about
  end
  
  def authenticate_user!
    redirect_to root_path, notice: 'ログインしてください。' unless user_signed_in?
  end
end
