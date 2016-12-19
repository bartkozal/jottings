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

ActiveRecord::Schema.define(version: 20161219134641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_bookmarks_on_document_id", using: :btree
    t.index ["user_id"], name: "index_bookmarks_on_user_id", using: :btree
  end

  create_table "collaborations", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "invite_email"
    t.integer  "stack_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_collaborations_on_deleted_at", using: :btree
    t.index ["stack_id"], name: "index_collaborations_on_stack_id", using: :btree
    t.index ["user_id"], name: "index_collaborations_on_user_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "stack_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.string   "online_users", default: [], null: false, array: true
    t.index ["deleted_at"], name: "index_documents_on_deleted_at", using: :btree
    t.index ["stack_id"], name: "index_documents_on_stack_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.hstore   "answers"
    t.text     "comment"
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
  end

  create_table "stacks", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_stacks_on_deleted_at", using: :btree
    t.index ["owner_id"], name: "index_stacks_on_owner_id", using: :btree
    t.index ["user_id"], name: "index_stacks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "bookmarks", "documents"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "collaborations", "stacks"
  add_foreign_key "documents", "stacks"
end
