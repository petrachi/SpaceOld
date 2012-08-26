class CreateGameRequirements < ActiveRecord::Migration
  def change
    create_table :game_requirements do |t|
      t.string :object_type
      t.integer :object_id
      t.float :lvl

      t.timestamps
    end
  end
end
