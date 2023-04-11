class RemoveFavoriteCountFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :favorite_count, :integer
  end
end
