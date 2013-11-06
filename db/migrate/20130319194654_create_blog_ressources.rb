class CreateBlogRessources < ActiveRecord::Migration
  def change
    create_table :blog_ressources do |t|
      t.references :user
      
      t.string :title
      t.text :summary
      t.string :link
      
      t.string :pool
      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag
      
      t.timestamps
    end
    add_index :blog_ressources, :user_id
    add_index :blog_ressources, :tag
  end
end
