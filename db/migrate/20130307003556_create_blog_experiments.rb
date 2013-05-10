class CreateBlogExperiments < ActiveRecord::Migration
  def change
    create_table :blog_experiments do |t|
      t.references :user
      t.references :article
      
      t.string :title
      t.text :summary
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_experiments, :user_id
    add_index :blog_experiments, :article_id
  end
end
