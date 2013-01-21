class CreateGameTechnologies < ActiveRecord::Migration
  def change
    create_table :game_technologies do |t|
      t.string :name
      t.string :descr
      t.string :brief
      t.string :domain
      t.float :domain_modifier
      t.integer :research_time
      t.integer :cost

      t.timestamps
    end
  end
end
