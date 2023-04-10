class Post < ApplicationRecord
  has_many_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: [ less_than: 1.megabytes] }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
