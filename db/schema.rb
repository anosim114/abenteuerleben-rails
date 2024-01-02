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

ActiveRecord::Schema[7.1].define(version: 2024_01_01_232129) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "camps", force: :cascade do |t|
    t.integer "campyear_id", null: false
    t.date "date_start"
    t.date "date_end"
    t.integer "participants_year_start"
    t.integer "participants_year_end"
    t.integer "max_participant_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "price"
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

  create_table "children", force: :cascade do |t|
    t.string "surname"
    t.string "forename"
    t.date "birthday"
    t.string "sex"
    t.string "medicals"
    t.string "notes"
    t.integer "parent_id", null: false
    t.integer "camp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_children_on_camp_id"
    t.index ["parent_id"], name: "index_children_on_parent_id"
  end

  create_table "downloads", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "download_area"
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

  create_table "helpers", force: :cascade do |t|
    t.string "surname", null: false
    t.string "forename", null: false
    t.date "birthday", null: false
    t.string "telephone", null: false
    t.string "email", null: false
    t.string "streethouse", null: false
    t.string "postcity", null: false
    t.text "story", null: false
    t.string "duty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "birthplace"
    t.string "preferredCamp"
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

  create_table "parents", force: :cascade do |t|
    t.string "surname"
    t.string "forename"
    t.string "telephone"
    t.string "housephone"
    t.string "email"
    t.string "street"
    t.string "house"
    t.string "post"
    t.string "city"
    t.boolean "member"
    t.string "church"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "helper_id", null: false
    t.integer "camp_id", null: false
    t.string "wish_first", null: false
    t.string "wish_second", null: false
    t.boolean "participate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_registrations_on_camp_id"
    t.index ["helper_id"], name: "index_registrations_on_helper_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.boolean "enabled"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "camps", "campyears"
  add_foreign_key "children", "camps"
  add_foreign_key "children", "parents"
  add_foreign_key "registrations", "camps"
  add_foreign_key "registrations", "helpers"
end
