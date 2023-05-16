class Public::UsersController < ApplicationController
before_action :ensure_guest_user, only: [:edit]
before_action :destroy_guest_user, only: [:unsubscribe]
before_action :set_user, only: [:show, :edit, :update,]
before_action :authenticate_user!

  def show
    # @reviews = current_user.reviews.includes(:movie)
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
    @user = User.find(params[:id])
    @liked_movies = @user.liked_movies.order(created_at: :desc)
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
  
  def destroy_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーは退会できません。'
    end
  end
   

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

  def authenticate_user!
    redirect_to root_path, notice: 'ログインしてください。' unless user_signed_in?
  end

end