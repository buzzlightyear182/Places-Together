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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140822125401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "activity_name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
  end

  create_table "places", force: true do |t|
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "surname"
    t.float    "rating"
    t.string   "occupation"
    t.date     "birthday"
    t.string   "hometown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "links",      default: "---\n:Facebook: ''\n:Twitter: ''\n:Instagram: ''\n:Google: ''\n:Blog: ''\n"
    t.text     "languages",  default: "---\n- English\n"
  end

  create_table "trips", force: true do |t|
    t.integer  "organizer"
    t.integer  "place_id"
    t.integer  "activity_id"
    t.date     "from_date"
    t.date     "to_date"
    t.string   "description"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", force: true do |t|
    t.string   "first_name"
    t.string   "surname"
    t.integer  "age"
    t.string   "home_base"
    t.string   "country"
    t.string   "languages"
    t.string   "about_me"
    t.string   "occupation"
    t.string   "links"
    t.string   "traveller"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
