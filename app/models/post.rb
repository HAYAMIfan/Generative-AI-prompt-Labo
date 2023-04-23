class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
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
  
  def self.search_by_keyword(query:)
    query.result(distinct: true).order("created_at DESC")
  end

  def self.search_by_tag(tag:)
    tag.posts.order("created_at DESC")
  end
# 週間のお気に入り数でランキングを作成する
  def self.create_all_ranks
    #Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').pluck(:post_id))
    Post.find(Favorite.group(:post_id).where(created_at: Time.current.ago(7.days)..Time.current).order('count(post_id) desc').pluck(:post_id))
  end
  
  def self.post_by_followings(user_id:)
    relationships = Relationship.where(follower_id: user_id)
    Post.includes(:user).where(users: { is_stopped: false }).where(users: { id: relationships.pluck(:followed_id) }).order("posts.created_at DESC")
  end

  def self.post_recent
    Post.includes(:user).where(users: { is_stopped: false }).order("posts.created_at DESC")
  end

  def save_post_tag(tags)
    # 既にタグがあれば全取得
     current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 共通要素の取り出し
     old_tags = current_tags - tags
     new_tags = tags - current_tags
    # 古いタグの削除
     old_tags.each do |old|
       self.tags.delete Tag.find_by(tag_name: old)
     end

     new_tags.each do |new|
       new_post_tag = Tag.find_or_create_by(tag_name: new)
       self.tags << new_post_tag
     end
  end
end
