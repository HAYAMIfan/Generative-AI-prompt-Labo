module PostsHelper
  def desplay_icon(icon)
    if icon.present?
      @post.user.get_icon(64,64)
    else
      "no-icon.png"
    end
  end
end
