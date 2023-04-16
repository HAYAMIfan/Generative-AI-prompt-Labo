class HomesController < ApplicationController
  def top
    @all_ranks = Post.create_all_ranks
    if current_user
      relationships = Relationship.where(follower_id: current_user.id)
      # byebug
      @following_posts = Post.includes(:user).where(users: { is_stopped: false }).where(users: { id: relationships.pluck(:followed_id) }).order("posts.created_at DESC").limit(3)
    else
      @following_posts = []
    end
    @posts = Post.includes(:user).where(users: { is_stopped: false }).order("posts.created_at DESC").limit(3)
  end
end
