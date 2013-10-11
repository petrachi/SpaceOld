class CreateBlogSnippets < ActiveRecord::Migration
  def change
    create_table :blog_snippets do |t|
      t.references :runnable, polymorphic: true
      t.references :primal
      t.string :mutation
      
      t.text :params
      t.text :ruby
      t.text :scss
      t.text :erb
      t.text :js
      
      t.string :fingerprint
      t.text :compiled, :limit => 16.megabytes - 1
      
      t.boolean :published, :default => false
      
      t.timestamps
    end
    add_index :blog_snippets, [:runnable_id, :runnable_type]
    add_index :blog_snippets, :primal_id
  end
end
