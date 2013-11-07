class CreateBlogScreencasts < ActiveRecord::Migration
  def change
    create_table :blog_screencasts do |t|
      t.references :user
      t.references :following
      
      t.string :title
      t.text :summary
      t.string :embed
      
      t.string :pool
      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag
      t.string :serie

      t.timestamps
    end
    add_index :blog_screencasts, :user_id
    add_index :blog_screencasts, :following_id
    add_index :blog_screencasts, :tag
  end
end
