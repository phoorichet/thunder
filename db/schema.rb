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

ActiveRecord::Schema.define(version: 20150604054517) do

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
    t.integer  "insured_user_id"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "number"
    t.integer  "main_rider_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "coverages", force: :cascade do |t|
    t.string   "name"
    t.float    "assured_amount"
    t.string   "category"
    t.integer  "rider_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "premium_amount"
    t.string   "premium_unit"
    t.string   "coverage_unit"
    t.string   "coverage_end_at"
    t.text     "description"
    t.string   "coverage_type"
    t.integer  "reference_id"
  end

  add_index "coverages", ["coverage_type"], name: "index_coverages_on_coverage_type", using: :btree

  create_table "insured_users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.datetime "date_of_birth"
    t.string   "marital_status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ancestry"
    t.integer  "spouse_id"
    t.float    "income"
    t.string   "national_id"
    t.string   "passport_id"
    t.float    "height"
    t.float    "weight"
    t.string   "occupation"
  end

  add_index "insured_users", ["ancestry"], name: "index_insured_users_on_ancestry", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "plan_type"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "book_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "master_plan_id"
    t.integer  "reference_id"
  end

  add_index "plans", ["plan_type"], name: "index_plans_on_plan_type", using: :btree

  create_table "returns", force: :cascade do |t|
    t.string   "return_type"
    t.float    "amount"
    t.integer  "relative_year"
    t.integer  "coverage_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "riders", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "number"
    t.string   "description"
    t.string   "status"
    t.string   "rider_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "plan_id"
    t.integer  "reference_id"
    t.string   "code_name"
  end

  add_index "riders", ["rider_type"], name: "index_riders_on_rider_type", using: :btree

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
    t.string   "username"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "unique_session_id",      limit: 20
    t.string   "provider"
    t.string   "uid",                               default: "", null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "tokens"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
