class CreateGameSquadJoins < ActiveRecord::Migration
  def change
    create_table :game_squad_joins do |t|
      t.references :game_user
      t.references :game_province
      t.references :game_squad
      t.integer :current_employment
      t.float :lvl

      t.timestamps
    end
  end
end
