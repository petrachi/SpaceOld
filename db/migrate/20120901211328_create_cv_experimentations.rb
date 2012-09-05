class CreateCvExperimentations < ActiveRecord::Migration
  def change
    create_table :cv_experimentations do |t|
      t.references :user
      t.string :name
      t.string :brief
      t.text :description
      t.text :controller
      t.text :view

      t.timestamps
    end
    add_index :cv_experimentations, :user_id
  end
end
