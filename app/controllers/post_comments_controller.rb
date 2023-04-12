class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
    @post_comments =  @post.post_comments.includes(:user).where(users: { is_stopped: false })
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
    @post_comments =  @post.post_comments.includes(:user).where(users: { is_stopped: false })
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
