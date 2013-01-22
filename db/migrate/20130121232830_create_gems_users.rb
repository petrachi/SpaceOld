class CreateGemsUsers < ActiveRecord::Migration
  def change
    create_table :gems_users do |t|
      t.references :main_user
      
      t.timestamps
    end
  end
end
