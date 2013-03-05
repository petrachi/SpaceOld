class CreateBlogUsers < ActiveRecord::Migration
  def change
    create_table :blog_users do |t|
      t.references :main_user

      t.timestamps
    end
    add_index :blog_users, :main_user_id
  end
end
