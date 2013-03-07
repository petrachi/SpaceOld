class CreateBlogExperiments < ActiveRecord::Migration
  def change
    create_table :blog_experiments do |t|
      t.references :blog_user
      t.string :title
      t.string :summary
      t.text :block
      
      t.boolean :published
      t.timestamps
    end
    add_index :blog_experiments, :blog_user_id
  end
end