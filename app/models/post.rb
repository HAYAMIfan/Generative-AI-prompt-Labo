class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :images, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: [ less_than: 1.megabytes] }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
