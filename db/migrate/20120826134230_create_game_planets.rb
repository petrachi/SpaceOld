class CreateGamePlanets < ActiveRecord::Migration
  def change
    create_table :game_planets do |t|
      t.integer :size

      t.timestamps
    end
  end
end
