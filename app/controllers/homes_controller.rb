class HomesController < ApplicationController
  def top
    #ランキング表示
    @all_ranks = Post.create_all_ranks
    @all_ranks = Kaminari.paginate_array(@all_ranks).page(params[:page]).per(4)

    if current_user
      relationships = Relationship.where(follower_id: current_user.id)
      @following_posts = Post.includes(:user).where(users: { is_stopped: false }).where(users: { id: relationships.pluck(:followed_id) }).order("posts.created_at DESC")
      @following_posts = Kaminari.paginate_array(@following_posts).page(params[:page]).per(4)
    else
      @following_posts = []
    end
    @posts = Post.includes(:user).where(users: { is_stopped: false }).order("posts.created_at DESC")
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(16)
  end
end
