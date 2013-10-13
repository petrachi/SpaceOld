class CreateBlogUsers < ActiveRecord::Migration
  def change
    create_table :blog_users do |t|
      t.references :user

      t.timestamps
    end
    add_index :blog_users, :user_id
  end
end
