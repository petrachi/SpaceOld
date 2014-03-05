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

ActiveRecord::Schema.define(:version => 20140305192236) do

  create_table "blog_articles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.string   "title"
    t.text     "summary"
    t.string   "pool"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.string   "serie"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "blog_articles", ["following_id"], :name => "index_blog_articles_on_following_id"
  add_index "blog_articles", ["tag"], :name => "index_blog_articles_on_tag"
  add_index "blog_articles", ["user_id"], :name => "index_blog_articles_on_user_id"

  create_table "blog_experiences", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.string   "pool"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.string   "serie"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "blog_experiences", ["tag"], :name => "index_blog_experiences_on_tag"
  add_index "blog_experiences", ["user_id"], :name => "index_blog_experiences_on_user_id"

  create_table "blog_ressources", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "summary"
    t.string   "link"
    t.string   "pool"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "blog_ressources", ["tag"], :name => "index_blog_ressources_on_tag"
  add_index "blog_ressources", ["user_id"], :name => "index_blog_ressources_on_user_id"

  create_table "blog_screencasts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.string   "title"
    t.text     "summary"
    t.string   "embed"
    t.string   "pool"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.string   "serie"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "blog_screencasts", ["following_id"], :name => "index_blog_screencasts_on_following_id"
  add_index "blog_screencasts", ["tag"], :name => "index_blog_screencasts_on_tag"
  add_index "blog_screencasts", ["user_id"], :name => "index_blog_screencasts_on_user_id"

  create_table "blog_users", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_users", ["user_id"], :name => "index_blog_users_on_user_id"

  create_table "snippets", :force => true do |t|
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
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "snippets", ["primal_id"], :name => "index_snippets_on_primal_id"
  add_index "snippets", ["runnable_id", "runnable_type"], :name => "index_snippets_on_runnable_id_and_runnable_type"

  create_table "stol_methods", :force => true do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.string   "title"
    t.text     "summary"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "stol_methods", ["tag"], :name => "index_stol_methods_on_tag"
  add_index "stol_methods", ["user_id"], :name => "index_stol_methods_on_user_id"
  add_index "stol_methods", ["version_id"], :name => "index_stol_methods_on_version_id"

  create_table "stol_services", :force => true do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.string   "title"
    t.text     "summary"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "stol_services", ["tag"], :name => "index_stol_services_on_tag"
  add_index "stol_services", ["user_id"], :name => "index_stol_services_on_user_id"
  add_index "stol_services", ["version_id"], :name => "index_stol_services_on_version_id"

  create_table "stol_setups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.string   "title"
    t.text     "summary"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "stol_setups", ["tag"], :name => "index_stol_setups_on_tag"
  add_index "stol_setups", ["user_id"], :name => "index_stol_setups_on_user_id"
  add_index "stol_setups", ["version_id"], :name => "index_stol_setups_on_version_id"

  create_table "stol_users", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stol_users", ["user_id"], :name => "index_stol_users_on_user_id"

  create_table "stol_versions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.string   "title"
    t.text     "summary"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.string   "tag"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "stol_versions", ["tag"], :name => "index_stol_versions_on_tag"
  add_index "stol_versions", ["user_id"], :name => "index_stol_versions_on_user_id"
  add_index "stol_versions", ["version_id"], :name => "index_stol_versions_on_version_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
