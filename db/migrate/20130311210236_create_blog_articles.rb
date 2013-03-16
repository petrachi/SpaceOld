class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.references :blog_user
      t.string :title
      t.text :summary
      t.text :content, :limit => 4.gigabytes - 1
      
      t.boolean :published, :default => false
      t.timestamps
    end
    add_index :blog_articles, :blog_user_id
  end
end
