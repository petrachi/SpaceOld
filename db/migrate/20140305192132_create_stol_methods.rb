class CreateStolMethods < ActiveRecord::Migration
  def change
    create_table :stol_methods do |t|
      t.references :user
      t.references :version

      t.string :title
      t.text :summary

      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag

      t.timestamps
    end
    add_index :stol_methods, :user_id
    add_index :stol_methods, :version_id
    add_index :stol_methods, :tag
  end
end
