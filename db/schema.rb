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

ActiveRecord::Schema[7.0].define(version: 2023_09_15_193800) do
  create_table "camps", force: :cascade do |t|
    t.integer "campyear_id", null: false
    t.date "date_start"
    t.date "date_end"
    t.integer "participants_year_start"
    t.integer "participants_year_end"
    t.integer "max_participant_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campyear_id"], name: "index_camps_on_campyear_id"
  end

  create_table "campyears", force: :cascade do |t|
    t.integer "year"
    t.date "participants_register_start"
    t.date "participants_register_end"
    t.date "helper_register_start"
    t.date "helper_register_end"
    t.string "accentcolor_primary"
    t.string "accentcolor_secondary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "start_date", null: false
    t.date "end_date"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "url"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_hash"
    t.integer "level"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "camps", "campyears"
end
