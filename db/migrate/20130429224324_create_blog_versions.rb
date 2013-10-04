class CreateBlogVersions < ActiveRecord::Migration
  def change
    create_table :blog_versions do |t|
      t.references :user
      t.references :experiment
      
      t.text :params
      t.text :ruby
      t.text :scss
      t.text :erb
      t.text :js
      
      t.string :scss_md5
      t.text :precompiled_scss, :limit => 16.megabytes - 1
      
      t.references :primal
      t.string :mutation
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_versions, :user_id
    add_index :blog_versions, :experiment_id
    add_index :blog_versions, :primal_id
  end
end
