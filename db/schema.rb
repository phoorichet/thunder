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

ActiveRecord::Schema.define(version: 20150511054135) do

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

  create_table "contracts", force: :cascade do |t|
    t.integer  "insured_user_id"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "number"
    t.integer  "main_plan_id"
    t.integer  "package_plan_id"
    t.integer  "personal_accident_plan_id"
  end

  create_table "coverages", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.float    "coverage_amount"
    t.string   "category"
    t.integer  "rider_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "abbr"
    t.float    "premium_amount"
    t.string   "premium_unit"
    t.string   "coverage_unit"
    t.string   "coverage_end_at"
  end

  create_table "insurances", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "begin_at"
    t.string   "end_at"
    t.string   "status"
    t.integer  "master_insurance_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

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

  create_table "main_insurances", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "main_plans", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "master_insurances", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "begin_at"
    t.string   "end_at"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "master_riders", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "code_name"
  end

  create_table "package_plans", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "rider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_accident_plans", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "rider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "premiums", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.float    "amount"
    t.integer  "rider_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "master_rider_id"
    t.integer  "master_insurace_id"
    t.integer  "insurance_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "number"
    t.string   "description"
    t.string   "status"
    t.string   "rider_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "contract_id"
    t.integer  "master_rider_id"
    t.string   "code_name"
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
