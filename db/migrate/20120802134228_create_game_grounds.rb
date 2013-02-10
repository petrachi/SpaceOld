class CreateGameGrounds < ActiveRecord::Migration
  def change
    create_table :game_grounds do |t|
      t.references :game_province
      t.string :environment

      t.timestamps
    end
  end
end
