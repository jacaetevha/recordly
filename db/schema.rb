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

ActiveRecord::Schema.define(version: 20151229230546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_records", id: false, force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "artist_id", null: false
  end

  add_index "artists_records", ["artist_id"], name: "index_artists_records_on_artist_id", using: :btree
  add_index "artists_records", ["record_id"], name: "index_artists_records_on_record_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.string   "model_class"
    t.integer  "model_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "favorites", ["model_class", "model_id"], name: "model_uniqueness_cnstr", unique: true, using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.string   "title",          null: false
    t.string   "ordinal_letter", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "records_songs", id: false, force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "song_id",   null: false
  end

  add_index "records_songs", ["record_id"], name: "index_records_songs_on_record_id", using: :btree
  add_index "records_songs", ["song_id"], name: "index_records_songs_on_song_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "ordinal",    null: false
    t.integer  "record_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "songs", ["title", "record_id"], name: "song_record_chk", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "favorites", "users"
  add_foreign_key "records", "users"
  add_foreign_key "songs", "records"
end
