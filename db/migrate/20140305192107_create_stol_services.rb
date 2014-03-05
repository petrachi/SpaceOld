class CreateStolServices < ActiveRecord::Migration
  def change
    create_table :stol_services do |t|
      t.references :user
      t.references :version

      t.string :title
      t.text :summary

      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :tag

      t.timestamps
    end
    add_index :stol_services, :user_id
    add_index :stol_services, :version_id
    add_index :stol_services, :tag
  end
end
