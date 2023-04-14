class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :images, blob: { content_type: %w[image/png image/jpg image/jpeg], size: [ less_than: 1.megabytes] }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title content]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[title content]
  end

  def save_tag(sent_tags)
     current_tags = self.tags.pluck(:name) unless self.tags.nil?　#現存するタグがあればタグ名を配列として取得
     old_tags = current_tags - sent_tags　#
     new_tags = sent_tags - current_tags

     old_tags.each do |old|
       self.tags.delete Tag.find_by(tag_name: old)
     end

     new_tags.each do |new|
       new_post_tag = Tag.find_or_create_by(tag_name: new)
       self.tags << new_post_tag
     end
  end
end
