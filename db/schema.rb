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

ActiveRecord::Schema.define(version: 20171023013312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.integer  "arcade_machine_id"
    t.string   "token"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "api_keys", ["arcade_machine_id"], name: "index_api_keys_on_arcade_machine_id", using: :btree
  add_index "api_keys", ["token"], name: "index_api_keys_on_token", using: :btree

  create_table "approval_requests", force: :cascade do |t|
    t.integer  "approvable_id"
    t.string   "approvable_type"
    t.text     "notes"
    t.datetime "approved_at"
    t.datetime "refused_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "arcade_machines", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "location"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.integer  "players"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "mappable",    default: true
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "game_ownerships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_ownerships", ["game_id"], name: "index_game_ownerships_on_game_id", using: :btree
  add_index "game_ownerships", ["user_id"], name: "index_game_ownerships_on_user_id", using: :btree

  create_table "game_zips", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "file_key"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.datetime "file_last_modified"
    t.string   "executable"
  end

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "min_players"
    t.integer  "max_players"
    t.string   "slug"
    t.datetime "published_at"
  end

  add_index "games", ["published_at"], name: "index_games_on_published_at", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "file_key"
    t.datetime "file_last_modified"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id"
    t.boolean  "cover",              default: false
  end

  add_index "images", ["parent_type", "parent_id"], name: "index_images_on_parent_type_and_parent_id", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "key_maps", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "template",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.json     "custom_map"
  end

  create_table "links", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "url"
    t.string   "link_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "links", ["parent_type", "parent_id"], name: "index_links_on_parent_type_and_parent_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "playlist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "listings", ["game_id"], name: "index_listings_on_game_id", using: :btree
  add_index "listings", ["playlist_id"], name: "index_listings_on_playlist_id", using: :btree

  create_table "logged_events", force: :cascade do |t|
    t.integer  "actor_id"
    t.string   "actor_type"
    t.json     "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "logged_events", ["actor_type", "actor_id"], name: "index_logged_events_on_actor_type_and_actor_id", using: :btree

  create_table "machine_ownerships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "arcade_machine_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "machine_ownerships", ["arcade_machine_id"], name: "index_machine_ownerships_on_arcade_machine_id", using: :btree
  add_index "machine_ownerships", ["user_id"], name: "index_machine_ownerships_on_user_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "default",     default: false
    t.text     "description"
    t.string   "slug"
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "arcade_machine_id"
    t.integer  "playlist_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
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
    t.boolean  "admin"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
