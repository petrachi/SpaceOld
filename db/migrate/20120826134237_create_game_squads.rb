class CreateGameSquads < ActiveRecord::Migration
  def change
    create_table :game_squads do |t|
      t.string :name
      t.string :descr
      t.string :brief
      t.integer :base_atq
      t.integer :base_def
      t.integer :base_move
      t.integer :base_range
      t.integer :base_precision
      t.integer :base_employment
      t.integer :atq_modifier
      t.integer :def_modifier
      t.integer :move_modifier
      t.integer :range_modifier
      t.integer :precision_modifier
      t.integer :employment_modifier
      t.integer :recuitment_time
      t.integer :cost

      t.timestamps
    end
  end
end
