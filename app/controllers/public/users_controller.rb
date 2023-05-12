class Public::UsersController < ApplicationController
before_action :ensure_guest_user, only: [:edit]
before_action :set_user, only: [:show, :edit, :update,]

  def show
    # @reviews = current_user.reviews.includes(:movie)
    @reviews = User.find(params[:id]).reviews.includes(:movie)
  end

  def edit
    if @user != current_user
      redirect_to root_path, alert: "権限がありません"
    end
  end

  def update
    if @user != current_user
      redirect_to root_path, alert: "権限がありません"
      return
    end

    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def withdraw
    @user = current_user
    @user.membership_status = true
    if @user.save
      reset_session
      redirect_to root_path, notice: "退会が完了しました。"
    end
  end

  def unsubscribe
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end 

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end