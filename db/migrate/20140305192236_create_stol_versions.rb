class CreateStolVersions < ActiveRecord::Migration
  def change
    create_table :stol_versions do |t|
      t.references :user

      t.string :title
      t.text :summary

      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag

      t.timestamps
    end
    add_index :stol_versions, :user_id
    add_index :stol_versions, :tag
  end
end
