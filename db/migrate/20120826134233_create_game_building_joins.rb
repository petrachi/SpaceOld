class CreateGameBuildingJoins < ActiveRecord::Migration
  def change
    create_table :game_building_joins do |t|
      t.references :game_user
      t.references :game_province
      t.references :game_building
      t.integer :current_employment
      t.integer :current_production
      t.integer :current_stock
      t.float :lvl

      t.timestamps
    end
  end
end
