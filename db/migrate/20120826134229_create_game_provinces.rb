class CreateGameProvinces < ActiveRecord::Migration
  def change
    create_table :game_provinces do |t|
      t.references :game_user
      t.references :game_planet
      t.references :game_ground
      
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
