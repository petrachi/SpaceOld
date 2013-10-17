class CreateBlogScreencasts < ActiveRecord::Migration
  def change
    create_table :blog_screencasts do |t|
      t.references :user
      
      t.string :title
      t.text :summary
      t.string :embed
      
      t.string :pool
      t.boolean :published, :default => false
      t.string :tag

      t.timestamps
    end
    add_index :blog_screencasts, :user_id
    add_index :blog_screencasts, :tag
  end
end
