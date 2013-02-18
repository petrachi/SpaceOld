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

ActiveRecord::Schema.define(:version => 20130121232830) do

  create_table "game_building_joins", :force => true do |t|
    t.integer  "game_user_id"
    t.integer  "game_province_id"
    t.integer  "game_building_id"
    t.integer  "current_employment"
    t.integer  "current_production"
    t.integer  "current_stock"
    t.float    "lvl"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "game_buildings", :force => true do |t|
    t.string   "name"
    t.string   "descr"
    t.string   "brief"
    t.string   "product"
    t.integer  "base_employment"
    t.integer  "base_production"
    t.integer  "base_stock"
    t.integer  "employment_modifier"
    t.integer  "production_modifier"
    t.integer  "stock_modifier"
    t.integer  "construction_time"
    t.integer  "cost"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "game_buildings_game_requirements", :id => false, :force => true do |t|
    t.integer "game_building_id"
    t.integer "game_requirement_id"
  end

  create_table "game_grounds", :force => true do |t|
    t.integer  "game_province_id"
    t.string   "environment"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "game_planets", :force => true do |t|
    t.string   "name"
    t.integer  "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "game_provinces", :force => true do |t|
    t.integer  "game_user_id"
    t.integer  "game_planet_id"
    t.integer  "game_ground_id"
    t.float    "x"
    t.float    "y"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "game_requirements", :force => true do |t|
    t.string   "struct_type"
    t.integer  "struct_id"
    t.text     "block"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "game_requirements_game_squads", :id => false, :force => true do |t|
    t.integer "game_requirement_id"
    t.integer "game_squad_id"
  end

  create_table "game_requirements_game_technologies", :id => false, :force => true do |t|
    t.integer "game_requirement_id"
    t.integer "game_technology_id"
  end

  create_table "game_squad_joins", :force => true do |t|
    t.integer  "game_user_id"
    t.integer  "game_province_id"
    t.integer  "game_squad_id"
    t.integer  "current_employment"
    t.float    "lvl"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "game_squads", :force => true do |t|
    t.string   "name"
    t.string   "descr"
    t.string   "brief"
    t.integer  "base_atq"
    t.integer  "base_def"
    t.integer  "base_move"
    t.integer  "base_range"
    t.integer  "base_precision"
    t.integer  "base_employment"
    t.integer  "atq_modifier"
    t.integer  "def_modifier"
    t.integer  "move_modifier"
    t.integer  "range_modifier"
    t.integer  "precision_modifier"
    t.integer  "employment_modifier"
    t.integer  "recuitment_time"
    t.integer  "cost"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "game_technologies", :force => true do |t|
    t.string   "name"
    t.string   "descr"
    t.string   "brief"
    t.string   "domain"
    t.float    "domain_modifier"
    t.integer  "research_time"
    t.integer  "cost"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_technology_joins", :force => true do |t|
    t.integer  "game_user_id"
    t.integer  "game_province_id"
    t.integer  "game_technology_id"
    t.float    "lvl"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "game_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "gems_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "main_users", :force => true do |t|
    t.string   "first_name"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "super_user_users", :force => true do |t|
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
