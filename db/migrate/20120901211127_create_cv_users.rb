class CreateCvUsers < ActiveRecord::Migration
  def change
    create_table :cv_users do |t|
      t.references :main_user
      t.string :headline
      t.integer :age

      t.timestamps
    end
  end
end
