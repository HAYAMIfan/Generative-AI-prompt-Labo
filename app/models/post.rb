class Post < ApplicationRecord
  has_many_attached :image
  belongs_to :user

  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: [ less_than: 1.megabytes] }

end
