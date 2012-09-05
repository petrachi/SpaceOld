class CreateCvAchievements < ActiveRecord::Migration
  def change
    create_table :cv_achievements do |t|
      t.references :user
      t.string :year
      t.string :activity
      t.string :organisation
      t.string :location
      t.string :country
      t.string :brief
      t.text :description
      t.string :type

      t.timestamps
    end
    add_index :cv_achievements, :user_id
  end
end
