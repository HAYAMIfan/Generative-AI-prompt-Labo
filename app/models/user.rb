class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_one_attached :icon

  validates :icon, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  def get_icon(width,height)
    icon.variant( gravity: "center", crop: "128x128+0+0", resize: [width,height]).processed
  end
end
