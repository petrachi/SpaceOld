class CreateBlogExperiences < ActiveRecord::Migration
  def change
    create_table :blog_experiences do |t|
      t.references :user
      t.references :following
      
      t.string :title
      t.text :summary
      
      t.string :pool
      t.boolean :published, :default => false
      t.string :tag
      t.string :serie
      
      t.timestamps
    end
    add_index :blog_experiences, :user_id
    add_index :blog_experiences, :following_id
    add_index :blog_experiences, :tag
  end
end
