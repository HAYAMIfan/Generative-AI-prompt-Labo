class UsersController < ApplicationController

  before_action :authenticate_user!, except: %i[show index edit]
  before_action :authenticate_admin!, only: [:index]
  before_action :set_user, only: %i[show edit update stop restore]

  def show
    #userの投稿一覧
    @posts = @user.posts.order("created_at DESC").page(params[:page]).per(8)
    #いいね！した投稿一覧
    favorite_post_ids = Favorite.where(user_id: @user).pluck(:post_id)
    @favorite_posts = Post.includes(:user).where(
      users: {is_stopped: false},
      posts: {id: favorite_post_ids}).order("posts.created_at DESC")
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(8)
    
    @followings = @user.followings.where(is_stopped: false)#userがフォロー中のuser一覧
    @followers = @user.followers.where(is_stopped: false)#userをフォローしているuser一覧
    
    # 停止されたユーザーの詳細ページは管理人のみアクセス可能
    if @user.is_stopped? && !(current_user && current_user.is_admin?)
      redirect_to root_path
    end
  end

  def edit
    # ユーザー編集画面は停止されていない本人のみがアクセス可能
    redirect_to root_path if @user != current_user || @user.is_stopped?
  end

  def update
    @user.update(user_params) ? (redirect_to user_path(@user)) : (render :edit)
  end

  def stop#アカウント停止
    redirect_to request.referer if @user.update(is_stopped: true)
  end

  def restore#アカウント復旧
    redirect_to request.referer if @user.update(is_stopped: false)
  end

  def index
    @q = User.ransack(params[:q])
    if params[:q].present?
      @users = @q.result.page(params[:page])
    else
      @users = User.page(params[:page])
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :description, :is_stopped, :icon )
  end
  
end
