class CreateStolSetups < ActiveRecord::Migration
  def change
    create_table :stol_setups do |t|
      t.references :user
      t.references :version

      t.string :title
      t.text :summary

      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag

      t.timestamps
    end
    add_index :stol_setups, :user_id
    add_index :stol_setups, :version_id
    add_index :stol_setups, :tag
  end
end
