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

ActiveRecord::Schema.define(version: 20150718070940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "growers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.string   "name",                            null: false
    t.string   "zipcode",                         null: false
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "growers", ["email"], name: "index_growers_on_email", unique: true, using: :btree
  add_index "growers", ["zipcode"], name: "index_growers_on_zipcode", using: :btree

  create_table "lists", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "grower_id",               null: false
    t.jsonb    "items",      default: []
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
