class CreateGameRequirements < ActiveRecord::Migration
  def change
    create_table :game_requirements do |t|
      t.string :struct_type
      t.integer :struct_id
      t.text :block

      t.timestamps
    end
  end
end
