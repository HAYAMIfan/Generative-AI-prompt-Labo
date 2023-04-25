class TagsController < ApplicationController
  def index
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end
end
