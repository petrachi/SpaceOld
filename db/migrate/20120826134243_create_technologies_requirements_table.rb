class CreateTechnologiesRequirementsTable < ActiveRecord::Migration
  def up
    create_table :game_requirements_game_technologies, :id => false do |t|
      t.references :game_requirement
      t.references :game_technology
    end
  end

  def down
    drop_table :game_requirements_game_technologies
  end
end
