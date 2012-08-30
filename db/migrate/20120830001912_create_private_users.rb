class CreatePrivateUsers < ActiveRecord::Migration
  def change
    create_table :private_users do |t|
      t.references :main_user
      t.boolean :access_authorized

      t.timestamps
    end
  end
end
