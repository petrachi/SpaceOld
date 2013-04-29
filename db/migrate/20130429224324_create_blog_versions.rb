class CreateBlogVersions < ActiveRecord::Migration
  def change
    create_table :blog_versions do |t|
      t.references :blog_experiment
      
      t.string :title
      t.text :code
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
  end
end
