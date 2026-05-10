# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_10_172209) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "event_vote_counters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "downvotes_count", default: 0
    t.bigint "event_id", null: false
    t.datetime "updated_at", null: false
    t.integer "upvotes_count", default: 0
    t.index ["event_id"], name: "index_event_vote_counters_on_event_id"
  end

  create_table "event_votes", force: :cascade do |t|
    t.string "clerk_user_id", null: false
    t.datetime "created_at", null: false
    t.bigint "event_id", null: false
    t.datetime "updated_at", null: false
    t.string "vote_type", null: false
    t.index ["event_id", "clerk_user_id"], name: "index_event_votes_on_event_id_and_clerk_user_id", unique: true
    t.index ["event_id"], name: "index_event_votes_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "external_id", null: false
    t.string "image_url"
    t.string "name", null: false
    t.datetime "start_at"
    t.datetime "updated_at", null: false
    t.integer "vote_count", default: 0
    t.index ["external_id"], name: "index_events_on_external_id", unique: true
  end

  add_foreign_key "event_vote_counters", "events"
  add_foreign_key "event_votes", "events"
end
