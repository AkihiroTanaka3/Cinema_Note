class Admin::UsersController < ApplicationController
  before_action :authenticate_user_or_admin!
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = User.find(params[:id]).reviews.includes(:movie)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  if @user.update(user_params)
   flash[:notice] = "編集しました"
   redirect_to admin_users_path
  else
   flash[:alert] = "空欄を入力してください"
   render 'edit'
  end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :membership_status)
  end

  def authenticate_user_or_admin!
    request.path.start_with?('/admin')
    authenticate_admin!
  end
end
