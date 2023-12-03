class Public::UsersController < ApplicationController
before_action :check_guest_user, only: [:edit, :unsubscribe]
before_action :set_user, only: [:show, :edit, :likes, :update]
before_action :authenticate_user!

  def show
    @reviews = User.find(params[:id]).reviews.includes(:movie).order(created_at: :desc)
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

  def likes
    @liked_movies = @user.liked_movies.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーは編集できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

  def authenticate_user!
    redirect_to root_path, notice: 'ログインしてください。' unless user_signed_in?
  end

end