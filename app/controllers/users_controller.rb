class UsersController < ApplicationController

  before_action :authenticate_user!, except: %i[show index edit]
  before_action :authenticate_admin!, only: [:index]
  before_action :set_user, only: %i[show edit update stop]

  def show
    @posts = @user.posts.order("created_at DESC").page(params[:page]).per(8)
    favorite_post_ids = Favorite.where(user_id: @user).pluck(:post_id)
    @favorite_posts = Post.where(id: favorite_post_ids)
    # BANされたユーザーの詳細ページは管理人のみアクセス可能
    redirect_to root_path if !current_user.is_admin? && @user.is_stopped?
  end

  def edit
    # ユーザー編集画面はBANされていない本人のみがアクセス可能
    redirect_to root_path if @user != current_user || @user.is_stopped?
  end

  def update
    @user.update(user_params) ? (redirect_to user_path(@user)) : (render :edit)
  end

  def stop
    redirect_to request.referer if @user.update(is_stopped: true)
  end

  def index
    @users = User.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :description, :is_stopped, :icon )
  end
end
