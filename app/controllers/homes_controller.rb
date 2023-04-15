class HomesController < ApplicationController
  def top
    @posts = Post.includes(:user).where(users: { is_stopped: false }).order("posts.created_at DESC").limit(3)
    @all_ranks = Post.create_all_ranks
  end
end
