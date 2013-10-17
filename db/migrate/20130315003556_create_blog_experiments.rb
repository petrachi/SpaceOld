class CreateBlogExperiments < ActiveRecord::Migration
  def change
    create_table :blog_experiments do |t|
      t.references :user
      
      t.string :title
      t.text :summary
      
      t.string :pool
      t.boolean :published, :default => false
      t.string :tag
      
      t.timestamps
    end
    add_index :blog_experiments, :user_id
    add_index :blog_experiments, :tag
  end
end
