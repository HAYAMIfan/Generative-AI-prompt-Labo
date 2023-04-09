class UsersController < ApplicationController

  before_action :authenticate_user!, except: %i[show index]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC").page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def stop
    @user = User.find(params[:id])
    if @user.update(is_stopped: true)
      redirect_to request.referer
    end
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:name, :description, :is_stopped, :icon )
  end
end
