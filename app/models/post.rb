class Post < ApplicationRecord
  extend OrderAsSpecified

  has_many_attached :images
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :weekly_favorites, lambda { where(created_at: Time.current.ago(7.days)..Time.current) } , class_name: 'Favorite'
  validates :images, blob: { content_type: %w[image/png image/jpg image/jpeg], size: [ less_than: 1.megabytes] }

  def self.ransackable_attributes(auth_object = nil)
    %w[title content]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[title content]
  end

  def self.search_by_keyword(query:)
    Post.includes(:user).where(
      users: {is_stopped: false},
      posts: {id: query.result(distinct: true).order("created_at DESC").pluck(:id)}
    )
  end

  def self.search_by_tag(tag:)
    Post.includes(:user).where(
      users: {is_stopped: false},
      posts: {id: tag.posts.order("posts.created_at DESC").pluck(:id)}
    )
  end

  def favorited_by?(user)
    Post.includes(:favorites)
    favorites.exists?(user_id: user.id)
  end
# 週間のお気に入り数でランキングを作成する
  def self.create_all_ranks
    # TODO: デプロイ時にこの箇所でエラーが出た場合、order_as_specifiedが原因の可能性が高い
    # refs: https://github.com/panorama-ed/order_as_specified
    favorites = Favorite.where(created_at: Time.current.ago(7.days)..Time.current).group(:post_id).order('count(post_id) desc').pluck(:post_id)
    Post.where(id: favorites).order_as_specified(id: favorites)

    # Post.joins(:user).left_joins(:weekly_favorites).where(user: { is_stopped: false} ).group(:id).order("count(favorites.post_id) desc")
#    Post.includes(:user).where(
#      users:{is_stopped: false},
#      posts:{id: Favorite.group(:post_id).where(created_at: Time.current.ago(7.days)..Time.current).order('count(post_id) desc').pluck(:post_id)}
#    )
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
