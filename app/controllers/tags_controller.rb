class TagsController < ApplicationController
  def index
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_back(fallback_location: posts_path)
  end
end
