class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.references :user
      t.references :following

      t.string :title
      t.text :summary

      t.string :pool
      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag
      t.string :serie

      t.timestamps
    end
    add_index :blog_articles, :user_id
    add_index :blog_articles, :following_id
    add_index :blog_articles, :tag
  end
end
