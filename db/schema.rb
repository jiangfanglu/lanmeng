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

ActiveRecord::Schema.define(:version => 20140621162058) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "zone_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "court_tournaments", :force => true do |t|
    t.integer  "court_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "courts", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followed_id"
    t.integer  "follower_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "game_stats", :force => true do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "game_tournaments", :force => true do |t|
    t.integer  "game_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "team_a_id"
    t.integer  "team_b_id"
    t.integer  "referal_id"
    t.datetime "time"
    t.integer  "court_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "player_game_stats", :force => true do |t|
    t.integer  "player_id"
    t.integer  "score"
    t.integer  "rebound"
    t.integer  "assist"
    t.integer  "block"
    t.integer  "dunk"
    t.integer  "steal"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "player_teams", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "number"
    t.string   "alias"
    t.integer  "user_id"
    t.integer  "total_score"
    t.integer  "total_rebound"
    t.integer  "total_assist"
    t.integer  "total_block"
    t.integer  "total_dunk"
    t.integer  "total_steal"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "profile"
  end

  create_table "referees", :force => true do |t|
    t.string   "name"
    t.integer  "game_count"
    t.integer  "rating"
    t.integer  "rating_count"
    t.integer  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "team_applications", :force => true do |t|
    t.integer  "applicant_user_id"
    t.integer  "applied_team_id"
    t.integer  "status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "team_stats", :force => true do |t|
    t.integer  "win"
    t.integer  "lose"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "team_tournaments", :force => true do |t|
    t.integer  "team_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.text     "description"
    t.integer  "member_count"
    t.integer  "captain_player_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.integer  "status"
    t.integer  "team_count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "city_id"
  end

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "telephone"
    t.string   "username"
    t.string   "name"
    t.string   "password"
    t.string   "salt"
    t.text     "cart"
    t.text     "wishlist"
    t.integer  "newsletter"
    t.integer  "user_group_id", :default => 1
    t.string   "ip"
    t.integer  "status",        :default => 1
    t.string   "token"
    t.integer  "thumbnail",     :default => 0
    t.text     "params"
    t.integer  "block",         :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "weblogs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "blog_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
