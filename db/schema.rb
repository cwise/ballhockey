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

ActiveRecord::Schema.define(:version => 20121027093335) do

  create_table "backup", :force => true do |t|
    t.string   "trigger"
    t.string   "adapter"
    t.string   "filename"
    t.string   "md5sum"
    t.string   "path"
    t.string   "bucket"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_goalies", :id => false, :force => true do |t|
    t.integer "game_id"
    t.date    "game_date"
    t.integer "player_id"
    t.string  "name"
  end

  create_table "game_players", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "equipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "goalie",        :default => false
    t.string   "current_state"
  end

  add_index "game_players", ["player_id"], :name => "fk_gameplayer_2_player"

  create_table "games", :force => true do |t|
    t.date     "game_date"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organizer",         :limit => 256
    t.string   "organizer_address", :limit => 256
    t.string   "current_state"
  end

  create_table "played_games", :id => false, :force => true do |t|
    t.integer  "id",               :default => 0, :null => false
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "player_status_id"
    t.integer  "equipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "goalie"
    t.date     "game_date"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        :default => true
  end

end
