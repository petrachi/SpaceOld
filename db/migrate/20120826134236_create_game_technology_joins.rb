class CreateGameTechnologyJoins < ActiveRecord::Migration
  def change
    create_table :game_technology_joins do |t|
      t.references :game_user
      t.references :game_province
      t.references :game_technology
      t.float :lvl

      t.timestamps
    end
  end
end
