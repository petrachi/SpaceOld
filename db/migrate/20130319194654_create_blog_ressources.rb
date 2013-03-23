class CreateBlogRessources < ActiveRecord::Migration
  def change
    create_table :blog_ressources do |t|
      t.references :blog_user
      t.references :source, :polymorphic => true
      
      t.string :title
      t.text :summary
      t.string :link
      
      t.string :pool
      t.boolean :public, :default => false
      t.boolean :published, :default => false
      
      t.timestamps
    end
  end
end
