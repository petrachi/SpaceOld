class CreateCvExperimentations < ActiveRecord::Migration
  def change
    create_table :cv_experimentations do |t|
      t.references :cv_user
      t.string :name
      t.string :brief
      t.text :description
      t.text :controller
      t.text :view

      t.timestamps
    end
    add_index :cv_experimentations, :cv_user_id
  end
end
