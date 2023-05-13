class Admin::UsersController < ApplicationController
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
  
  def user_params
    params.require(:user).permit(:name, :introduction, :membership_status)
  end
end
