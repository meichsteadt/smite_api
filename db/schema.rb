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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_26_215027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.integer "god_id"
    t.string "name"
    t.integer "cost_rank_1"
    t.integer "cost_rank_2"
    t.integer "cost_rank_3"
    t.integer "cost_rank_4"
    t.integer "cost_rank_5"
    t.integer "cooldown_rank_1"
    t.integer "cooldown_rank_2"
    t.integer "cooldown_rank_3"
    t.integer "cooldown_rank_4"
    t.integer "cooldown_rank_5"
    t.string "ability_type"
    t.string "affects"
    t.string "dmg_type"
    t.integer "range"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ability_effects", force: :cascade do |t|
    t.integer "ability_id"
    t.integer "duration_1"
    t.integer "duration_2"
    t.integer "duration_3"
    t.integer "duration_4"
    t.integer "duration_5"
    t.boolean "cc"
    t.string "description"
    t.float "dot_every"
    t.integer "min_percentage"
    t.integer "max_percentage"
    t.integer "progression_1"
    t.integer "progression_2"
    t.integer "progression_3"
    t.integer "progression_4"
    t.integer "progression_5"
    t.float "scaling"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "builds", force: :cascade do |t|
    t.integer "god_id"
    t.integer "item1_id"
    t.integer "active1_id"
    t.integer "active2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "god_ranks", force: :cascade do |t|
    t.integer "player_id"
    t.integer "god_id"
    t.integer "rank", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gods", force: :cascade do |t|
    t.string "god_card"
    t.string "god_icon"
    t.integer "smite_id"
    t.float "attack_speed"
    t.float "attack_speed_per_level"
    t.float "hp5_per_level"
    t.integer "health"
    t.integer "health_per_five"
    t.integer "health_per_level"
    t.float "mp5_per_level"
    t.integer "magic_protection"
    t.float "magic_protection_per_level"
    t.integer "magical_power"
    t.float "magical_power_per_level"
    t.integer "mana"
    t.float "mana_per_five"
    t.integer "mana_per_level"
    t.string "name"
    t.string "pantheon"
    t.integer "physical_power"
    t.float "physical_power_per_level"
    t.integer "physical_protection"
    t.float "physical_protection_per_level"
    t.string "roles"
    t.integer "speed"
    t.string "god_type"
    t.integer "basic_attack_dmg"
    t.float "basic_attack_dmg_per_level"
    t.float "basic_attack_progression", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_stats", force: :cascade do |t|
    t.integer "item_id"
    t.string "stat_type"
    t.integer "value"
    t.boolean "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "child_item_id"
    t.string "device_name"
    t.integer "icon_id"
    t.integer "item_id"
    t.integer "item_tier"
    t.integer "price"
    t.string "restricted_roles"
    t.integer "root_item_id"
    t.string "short_desc"
    t.boolean "starting_item"
    t.string "item_icon_url"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "test", default: false
  end

  create_table "player_matches", force: :cascade do |t|
    t.integer "match_id"
    t.integer "player_id"
    t.integer "account_level"
    t.integer "assists"
    t.integer "damage_mitigated"
    t.integer "damage_player"
    t.integer "damage_taken"
    t.integer "deaths"
    t.datetime "entry_datetime"
    t.integer "final_match_level"
    t.integer "god_id"
    t.integer "gold_earned"
    t.integer "gold_per_minute"
    t.integer "healing"
    t.integer "kills_fire_giant"
    t.integer "kills_first_blood"
    t.integer "kills_gold_fury"
    t.integer "kills_phoenix"
    t.integer "kills_player"
    t.integer "mastery_level"
    t.integer "minutes"
    t.integer "objective_assists"
    t.integer "structure_damage"
    t.integer "surrendered"
    t.integer "time_in_match_seconds"
    t.integer "towers_destroyed"
    t.integer "wards_placed"
    t.string "god_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "smite_match_id"
    t.integer "win_status"
    t.float "adj_gold_per_minute"
    t.float "damage_player_thousands"
    t.float "damage_mitigated_thousands"
    t.float "damage_taken_thousands"
    t.float "structure_damage_thousands"
    t.float "kd"
    t.float "kda"
    t.float "kill_participation"
  end

  create_table "players", force: :cascade do |t|
    t.string "avatar"
    t.datetime "created_datetime"
    t.integer "smite_id", default: 0
    t.datetime "last_login_datetime"
    t.integer "leaves", default: 0
    t.integer "level", default: 0
    t.integer "losses", default: 0
    t.integer "mastery_level", default: 0
    t.string "name"
    t.integer "rank_stat_duel", default: 0
    t.integer "rank_stat_conquest", default: 0
    t.integer "rank_stat_joust", default: 0
    t.string "region"
    t.integer "team_id", default: 0
    t.string "team_name"
    t.integer "tier_conquest", default: 0
    t.integer "tier_duel", default: 0
    t.integer "tier_joust", default: 0
    t.integer "total_achievements", default: 0
    t.integer "total_worshippers", default: 0
    t.integer "wins", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
