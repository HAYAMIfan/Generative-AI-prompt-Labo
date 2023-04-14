class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :icon

  validates :icon, blob: { content_type: %w[image/png image/jpg image/jpeg] }

  # アイコン画像を表示する
  def get_icon
    if icon.attached?
      icon.variant( gravity: "center", crop: "320x320+0+0", resize: "128x128",border: '2').processed
    else
      "default_icon.png"
    end
  end
  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

end
