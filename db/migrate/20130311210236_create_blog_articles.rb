class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.references :user
      
      t.string :title
      t.text :summary
      t.text :code
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_articles, :user_id
  end
end
