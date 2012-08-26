class CreateSquadsRequirementsTable < ActiveRecord::Migration
  def up
    create_table :game_requirements_game_squads, :id => false do |t|
      t.references :game_requirement
      t.references :game_squad
    end
  end

  def down
    drop_table :game_requirements_game_squads
  end
end
