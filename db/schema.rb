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

ActiveRecord::Schema.define(version: 20150430194050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "house_number"
    t.string   "village"
    t.string   "road"
    t.string   "subdistrict"
    t.string   "district"
    t.string   "province"
    t.string   "postal_code"
    t.string   "country"
    t.integer  "insured_user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "number"
    t.string   "description"
    t.string   "status"
    t.string   "book_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "insured_users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.datetime "birthdate"
    t.string   "marital_status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "riders", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "number"
    t.string   "description"
    t.string   "status"
    t.string   "rider_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
