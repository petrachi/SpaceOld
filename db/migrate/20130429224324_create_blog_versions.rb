class CreateBlogVersions < ActiveRecord::Migration
  def change
    create_table :blog_versions do |t|
      t.references :user
      t.references :experiment
      t.references :version
      
      t.text :params
      t.text :ruby
      t.text :scss
      t.text :erb
            
      t.integer :rank, :default => 1
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_versions, :user_id
    add_index :blog_versions, :experiment_id
    add_index :blog_versions, :version_id
  end
end
