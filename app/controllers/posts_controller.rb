class PostsController < ApplicationController

  before_action :authenticate_user!, except: %i[show index]
  before_action :set_post, only: %i[show edit update destroy]

  def show
    @post_tags = @post.tags
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.includes(:user).where(users: { is_stopped: false })
  end

  def edit
    user_id = @post.user_id
    # 管理者以外のユーザーが他人の投稿のeditページに移動できないようにする
    unless user_id == current_user.id || current_user.is_admin?
      redirect_to posts_path
    end
  end

  def update
    @post.update(post_params) ? (redirect_to post_path(@post)) : (render :edit)
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = Post.includes(:user).where(users: { is_stopped: false }).order("posts.created_at DESC").page(params[:page])
    @tag_list = Tag.includes(:post_tags).all
  end
  
  def search
    @q = Post.ransack(params[:q])
    @results = @q.result.order("created_at DESC").page(params[:page]).per(10)
  end


  def new
    @post = current_user.posts.new
    # 本文のテンプレート
    @post.content = "回答の満足度(10点満点で)：\n\nどんな回答が欲しかったか：\n\n回答の良かったor悪かった所：\n\n呪文について意識した点："
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:name].split(nil)
    @post.save && @post.save_tag(tag_list) ? (redirect_to post_path(@post), notice: "投稿が完了しました。") : (render :new)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :favorite_count, images: [] )
  end
end
