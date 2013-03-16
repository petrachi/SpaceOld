# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130311210236) do

  create_table "blog_articles", :force => true do |t|
    t.integer  "blog_user_id"
    t.string   "title"
    t.text     "summary"
    t.text     "content",      :limit => 2147483647
    t.boolean  "published",                          :default => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "blog_articles", ["blog_user_id"], :name => "index_blog_articles_on_blog_user_id"

  create_table "blog_experiments", :force => true do |t|
    t.integer  "blog_user_id"
    t.string   "title"
    t.text     "summary"
    t.text     "block"
    t.boolean  "published",    :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "blog_experiments", ["blog_user_id"], :name => "index_blog_experiments_on_blog_user_id"

  create_table "blog_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "blog_users", ["main_user_id"], :name => "index_blog_users_on_main_user_id"

  create_table "game_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "game_users", ["main_user_id"], :name => "index_game_users_on_main_user_id"

  create_table "gems_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "gems_users", ["main_user_id"], :name => "index_gems_users_on_main_user_id"

  create_table "main_users", :force => true do |t|
    t.string   "first_name"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "super_user_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "super_user_users", ["main_user_id"], :name => "index_super_user_users_on_main_user_id"

end
