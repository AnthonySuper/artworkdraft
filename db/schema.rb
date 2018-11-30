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

ActiveRecord::Schema.define(version: 2018_11_30_211816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "artwork_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.bigint "artwork_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_artwork_comments_on_artwork_id"
    t.index ["user_id"], name: "index_artwork_comments_on_user_id"
  end

  create_table "artwork_tags", force: :cascade do |t|
    t.bigint "artwork_id", null: false
    t.uuid "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_artwork_tags_on_artwork_id"
    t.index ["tag_id"], name: "index_artwork_tags_on_tag_id"
  end

  create_table "artworks", force: :cascade do |t|
    t.text "name", null: false
    t.text "description", default: "", null: false
    t.boolean "nsfw", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_artworks_on_user_id"
  end

  create_table "scrap_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.bigint "scrap_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scraps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "name", default: "", null: false
    t.text "description", default: "", null: false
    t.boolean "nsfw", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scraps_on_user_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.citext "name", null: false
    t.citext "email", null: false
    t.text "bio", default: "", null: false
    t.text "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "prefs", default: {}, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "artwork_comments", "artworks", on_delete: :cascade
  add_foreign_key "artwork_comments", "users", on_delete: :cascade
  add_foreign_key "artwork_tags", "artworks", on_delete: :cascade
  add_foreign_key "artwork_tags", "tags", on_delete: :cascade
  add_foreign_key "artworks", "users"
  add_foreign_key "scrap_comments", "scraps", on_delete: :cascade
  add_foreign_key "scrap_comments", "users", on_delete: :cascade
  add_foreign_key "scraps", "users", on_delete: :cascade
end
