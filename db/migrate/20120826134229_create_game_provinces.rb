class CreateGameProvinces < ActiveRecord::Migration
  def change
    create_table :game_provinces do |t|
      t.references :game_user
      t.references :game_planet
      t.string :environment

      t.timestamps
    end
  end
end
