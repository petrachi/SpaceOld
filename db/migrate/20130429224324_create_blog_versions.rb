class CreateBlogVersions < ActiveRecord::Migration
  def change
    create_table :blog_versions do |t|
      t.references :user
      t.references :experiment
      
      t.string :title
      t.text :code
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_versions, :user_id
    add_index :blog_versions, :experiment_id
  end
end
