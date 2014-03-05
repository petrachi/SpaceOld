class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
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

      t.timestamps
    end
    add_index :snippets, [:runnable_id, :runnable_type]
    add_index :snippets, :primal_id
  end
end
