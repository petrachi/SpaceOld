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

ActiveRecord::Schema.define(:version => 20130429224324) do

  create_table "blog_articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.text     "code"
    t.boolean  "published",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_articles", ["user_id"], :name => "index_blog_articles_on_user_id"

  create_table "blog_experiments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.string   "title"
    t.text     "summary"
    t.boolean  "published",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_experiments", ["article_id"], :name => "index_blog_experiments_on_article_id"
  add_index "blog_experiments", ["user_id"], :name => "index_blog_experiments_on_user_id"

  create_table "blog_ressources", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.string   "title"
    t.text     "summary"
    t.string   "link"
    t.string   "pool"
    t.boolean  "primal",     :default => false
    t.boolean  "published",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_ressources", ["article_id"], :name => "index_blog_ressources_on_article_id"
  add_index "blog_ressources", ["user_id"], :name => "index_blog_ressources_on_user_id"

  create_table "blog_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "blog_users", ["main_user_id"], :name => "index_blog_users_on_main_user_id"

  create_table "blog_versions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "experiment_id"
    t.integer  "version_id"
    t.text     "params"
    t.text     "ruby"
    t.text     "scss"
    t.text     "erb"
    t.text     "js"
    t.string   "mutation"
    t.boolean  "published",     :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "blog_versions", ["experiment_id"], :name => "index_blog_versions_on_experiment_id"
  add_index "blog_versions", ["user_id"], :name => "index_blog_versions_on_user_id"
  add_index "blog_versions", ["version_id"], :name => "index_blog_versions_on_version_id"

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
