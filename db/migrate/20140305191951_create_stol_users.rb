class CreateStolUsers < ActiveRecord::Migration
  def change
    create_table :stol_users do |t|
      t.references :user

      t.timestamps
    end
    add_index :stol_users, :user_id
  end
end
