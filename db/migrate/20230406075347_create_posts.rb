class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title,     null: false
      t.text :content,     null: false
      t.integer :favorite_count, default: 0
      t.timestamps
    end
  end
end
