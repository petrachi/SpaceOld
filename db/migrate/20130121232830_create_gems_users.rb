class CreateGemsUsers < ActiveRecord::Migration
  def change
    create_table :gems_users do |t|
      t.references :main_user
      
      t.timestamps
    end
    add_index :gems_users, :main_user_id
  end
end
