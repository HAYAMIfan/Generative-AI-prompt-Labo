class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post= Post.new
    @post.content = "回答の満足度(10点満点で)：\n\nどんな回答が欲しかったか：\n\n回答の良かったor悪かった所：\n\n呪文について意識した点："
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!
      redirect_to post_path(@post), notice: "投稿が完了しました。"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :favorite_count, :image )
  end

end
