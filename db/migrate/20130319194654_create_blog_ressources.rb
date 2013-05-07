class CreateBlogRessources < ActiveRecord::Migration
  def change
    create_table :blog_ressources do |t|
      t.references :user
      t.references :article
      
      t.string :title
      t.text :summary
      t.string :link
      
      t.string :pool
      t.boolean :primal, :default => false
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_ressources, :user_id
    add_index :blog_ressources, :article_id
  end
end
