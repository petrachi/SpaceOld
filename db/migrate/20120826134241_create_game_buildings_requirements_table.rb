class CreateGameBuildingsRequirementsTable < ActiveRecord::Migration
  def up
    create_table :game_buildings_game_requirements, :id => false do |t|
      t.references :game_building
      t.references :game_requirement
    end
  end

  def down
    drop_table :game_buildings_game_requirements
  end
end
