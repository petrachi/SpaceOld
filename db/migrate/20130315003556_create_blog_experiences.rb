class CreateBlogExperiences < ActiveRecord::Migration
  def change
    create_table :blog_experiences do |t|
      t.references :user
      
      t.string :title
      t.text :summary
      
      t.string :pool
      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag
      t.string :serie
      
      t.timestamps
    end
    add_index :blog_experiences, :user_id
    add_index :blog_experiences, :tag
  end
end
