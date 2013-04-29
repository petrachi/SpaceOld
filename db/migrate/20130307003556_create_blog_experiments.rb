class CreateBlogExperiments < ActiveRecord::Migration
  def change
    create_table :blog_experiments do |t|
      t.references :blog_user
      t.references :blog_article
      
      t.string :title
      t.text :summary
      t.text :code
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_experiments, :blog_user_id
    add_index :blog_experiments, :blog_article_id
  end
end
