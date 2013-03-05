class CreateSuperUserUsers < ActiveRecord::Migration
  def change
    create_table :super_user_users do |t|
      t.references :main_user
      
      t.timestamps
    end
    add_index :super_user_users, :main_user_id
  end
end
