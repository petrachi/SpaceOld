class CreateGameBuildings < ActiveRecord::Migration
  def change
    create_table :game_buildings do |t|
      t.string :name
      t.string :descr
      t.string :brief
      t.string :product
      t.integer :base_employment
      t.integer :base_production
      t.integer :base_stock
      t.integer :employment_modifier
      t.integer :production_modifier
      t.integer :stock_modifier
      t.integer :construction_time
      t.integer :cost

      t.timestamps
    end
  end
end
