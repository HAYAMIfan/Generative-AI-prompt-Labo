class PostsController < ApplicationController

  before_action :authenticate_user!, except: %i[show index search]
  before_action :set_post, only: %i[show edit update destroy]

  def show
    @post_tags = @post.tags
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.includes(:user).where(users: { is_stopped: false })
  end

  def edit
    @tag_list=@post.tags.pluck(:tag_name).join(nil)
    user_id = @post.user_id
    # 管理者以外のユーザーが他人の投稿のeditページに移動できないようにする
    unless user_id == current_user.id || current_user.is_admin?
      redirect_to posts_path
    end
  end

  def update
    if params[:post][:tag_name].present?
      tag_list = params[:post][:tag_name].split(nil)
      @post.save_post_tag(tag_list)
    end

    if @post.update(post_params)
      @post.save_post_tag(tag_list)
      redirect_to post_path(@post), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def index
    @q = Post.ransack(params[:q])
    @tag_list = Tag.includes(:post_tags).distinct.all
    if params[:q].present?
      @posts = Post.search_by_keyword(query: @q)
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = Post.search_by_tag(tag: @tag)
    elsif params[:ranking] == "true"#ランキング表示
      @posts = Post.create_all_ranks
    elsif params[:following] == "true"#フォローユーザーの投稿
      @posts = Post.post_by_followings(user_id: current_user.id)
    else#新着順がデフォルト
      @posts = Post.post_recent
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
  end

  def new
    @post = current_user.posts.new
    # 本文のテンプレート
    @post.content = "回答の満足度(10点満点で)：\n\nどんな回答が欲しかったか：\n\n回答の良かったor悪かった所：\n\n呪文について意識した点："
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      if params[:post][:tag_name].present?
        tag_list = params[:post][:tag_name].split(nil)
        @post.save_post_tag(tag_list)
      end
      redirect_to post_path(@post), notice: "投稿が完了しました。"
    else
      # flash.now[:error] = '作成に失敗しました'
      render :new
    end
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
