class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: [ less_than: 1.megabytes] }

  def get_image(width,height)
      image.variant(resize_to_limit: [width,height]).processed
  end

  # 問答のスクリーンショットの幅だけを調整するメソッド
  def get_SS
      image.variant(gravity: "center", crop: "800x100%+0+0" ).processed
  end

end
