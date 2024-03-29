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

ActiveRecord::Schema.define(version: 2019_07_20_084406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "readings", force: :cascade do |t|
    t.bigint "thermostat_id", null: false
    t.integer "tracking_number", null: false
    t.float "temperature", null: false
    t.float "humidity", null: false
    t.float "battery_charge", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thermostat_id"], name: "index_readings_on_thermostat_id"
  end

  create_table "thermostats", force: :cascade do |t|
    t.text "household_token"
    t.hstore "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "readings", "thermostats"
end
