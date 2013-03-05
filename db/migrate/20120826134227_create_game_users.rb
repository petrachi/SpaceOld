class CreateGameUsers < ActiveRecord::Migration
  def change
    create_table :game_users do |t|
      t.references :main_user

      t.timestamps
    end
    add_index :game_users, :main_user_id
  end
end
