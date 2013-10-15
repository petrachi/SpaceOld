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

ActiveRecord::Schema.define(:version => 20131015113637) do

  create_table "blog_articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.string   "pool"
    t.boolean  "published",  :default => false
    t.string   "tag"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_articles", ["user_id"], :name => "index_blog_articles_on_user_id"

  create_table "blog_experiments", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.string   "pool"
    t.boolean  "published",  :default => false
    t.string   "tag"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_experiments", ["user_id"], :name => "index_blog_experiments_on_user_id"

  create_table "blog_ressources", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.string   "link"
    t.string   "pool"
    t.boolean  "published",  :default => false
    t.string   "tag"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_ressources", ["user_id"], :name => "index_blog_ressources_on_user_id"

  create_table "blog_screencasts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.string   "embed"
    t.string   "pool"
    t.boolean  "published",  :default => false
    t.string   "tag"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_screencasts", ["user_id"], :name => "index_blog_screencasts_on_user_id"

  create_table "blog_snippets", :force => true do |t|
    t.integer  "runnable_id"
    t.string   "runnable_type"
    t.integer  "primal_id"
    t.string   "mutation"
    t.text     "params"
    t.text     "ruby"
    t.text     "scss"
    t.text     "erb"
    t.text     "js"
    t.string   "fingerprint"
    t.text     "compiled",      :limit => 16777215
    t.boolean  "published",                         :default => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "blog_snippets", ["primal_id"], :name => "index_blog_snippets_on_primal_id"
  add_index "blog_snippets", ["runnable_id", "runnable_type"], :name => "index_blog_snippets_on_runnable_id_and_runnable_type"

  create_table "blog_users", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_users", ["user_id"], :name => "index_blog_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
