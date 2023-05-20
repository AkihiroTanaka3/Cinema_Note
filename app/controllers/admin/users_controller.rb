class Admin::UsersController < ApplicationController
  before_action :authenticate_user_or_admin!
  before_action :set_user, only: [:show, :edit, :update,]
  
  def index
    @users = User.all
  end

  def show
    @reviews = User.find(params[:id]).reviews.includes(:movie)
  end

  def edit
  end

  def update
  if @user.update(user_params)
   flash[:notice] = "編集しました"
   redirect_to admin_users_path
  else
   flash[:alert] = "空欄を入力してください"
   render 'edit'
  end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :membership_status)
  end

  def authenticate_user_or_admin!
    request.path.start_with?('/admin')
    authenticate_admin!
  end
end
