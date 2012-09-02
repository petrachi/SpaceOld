class CreateUsers < ActiveRecord::Migration
  def change
    create_table :main_users do |t|
      t.string :first_name
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end