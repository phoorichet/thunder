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

ActiveRecord::Schema.define(version: 20150723082614) do

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
    t.integer  "person_id"
    t.date     "begin_at"
    t.date     "end_at"
    t.string   "number"
    t.integer  "main_plan_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "assured_person_id"
    t.integer  "payer_person_id"
  end

  add_index "books", ["person_id"], name: "index_books_on_person_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coverages", force: :cascade do |t|
    t.string   "key"
    t.integer  "rider_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "description"
    t.string   "coverage_type"
    t.integer  "reference_id"
    t.string   "value"
    t.integer  "coverage_id"
  end

  add_index "coverages", ["coverage_id"], name: "index_coverages_on_coverage_id", using: :btree
  add_index "coverages", ["coverage_type"], name: "index_coverages_on_coverage_type", using: :btree

  create_table "dividends", force: :cascade do |t|
    t.integer  "year"
    t.integer  "age"
    t.float    "amount"
    t.integer  "insurance_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "dividends", ["insurance_id"], name: "index_dividends_on_insurance_id", using: :btree

  create_table "insurances", force: :cascade do |t|
    t.string   "name"
    t.float    "amount",             default: 0.0
    t.float    "premium",            default: 0.0
    t.integer  "protection_length"
    t.integer  "paid_period_length"
    t.string   "consider_year"
    t.string   "consider_gender"
    t.string   "company"
    t.integer  "reference_id"
    t.integer  "book_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "minimum_age"
    t.integer  "maximum_age"
    t.string   "group"
    t.boolean  "is_main"
    t.string   "insurance_type"
    t.integer  "maximum_cover_age"
  end

  add_index "insurances", ["book_id"], name: "index_insurances_on_book_id", using: :btree

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
    t.string   "user_type"
  end

  add_index "insured_users", ["ancestry"], name: "index_insured_users_on_ancestry", using: :btree

  create_table "pa_coverages", force: :cascade do |t|
    t.string   "key"
    t.integer  "pa_id"
    t.text     "description"
    t.string   "coverage_type"
    t.integer  "reference_id"
    t.string   "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "pas", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "book_id"
    t.string   "pa_type"
    t.integer  "reference_id"
    t.text     "description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "premium",           default: 0.0
    t.float    "amount",            default: 0.0
    t.integer  "maximum_cover_age"
  end

  create_table "persons", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "marital_status"
    t.integer  "spouse_id"
    t.float    "income"
    t.string   "national_id"
    t.string   "passport_id"
    t.float    "height"
    t.float    "weight"
    t.string   "occupation"
    t.string   "person_type"
    t.boolean  "is_smoking"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ancestry"
    t.integer  "employer_id"
    t.integer  "user_id"
    t.string   "company"
    t.string   "mobile"
  end

  add_index "persons", ["ancestry"], name: "index_persons_on_ancestry", using: :btree
  add_index "persons", ["employer_id"], name: "index_persons_on_employer_id", using: :btree
  add_index "persons", ["spouse_id"], name: "index_persons_on_spouse_id", using: :btree
  add_index "persons", ["user_id"], name: "index_persons_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "plan_type"
    t.date     "begin_at"
    t.date     "end_at"
    t.integer  "book_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "master_plan_id"
    t.integer  "reference_id"
    t.boolean  "is_main",            default: false
    t.integer  "minimum_age"
    t.integer  "maximum_age"
    t.string   "consider_year"
    t.string   "consider_gender"
    t.boolean  "have_surrender"
    t.boolean  "have_dividend"
    t.integer  "paid_period_length"
    t.integer  "protection_length"
    t.string   "group"
    t.string   "company"
  end

  add_index "plans", ["plan_type"], name: "index_plans_on_plan_type", using: :btree

  create_table "protections", force: :cascade do |t|
    t.integer  "year"
    t.integer  "age"
    t.float    "amount"
    t.integer  "insurance_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "coverage_rate"
  end

  add_index "protections", ["insurance_id"], name: "index_protections_on_insurance_id", using: :btree

  create_table "returns", force: :cascade do |t|
    t.integer  "year"
    t.integer  "age"
    t.float    "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "insurance_id"
    t.float    "rate"
  end

  add_index "returns", ["insurance_id"], name: "index_returns_on_insurance_id", using: :btree

  create_table "riders", force: :cascade do |t|
    t.string   "name"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "description"
    t.string   "status"
    t.string   "rider_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "insurance_id"
    t.integer  "reference_id"
    t.string   "code_name"
    t.integer  "book_id"
    t.float    "premium"
    t.float    "amount"
    t.integer  "maximum_cover_age"
  end

  add_index "riders", ["book_id"], name: "index_riders_on_book_id", using: :btree
  add_index "riders", ["insurance_id"], name: "index_riders_on_insurance_id", using: :btree
  add_index "riders", ["rider_type"], name: "index_riders_on_rider_type", using: :btree

  create_table "surrenders", force: :cascade do |t|
    t.string   "surrender_type"
    t.integer  "year"
    t.integer  "assured_age"
    t.string   "cv"
    t.string   "rpu"
    t.string   "ecv"
    t.string   "eti"
    t.integer  "eti_year"
    t.integer  "eti_day"
    t.string   "etipe"
    t.integer  "insurance_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "surrenders", ["insurance_id"], name: "index_surrenders_on_insurance_id", using: :btree

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
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.string   "contact_number"
    t.string   "job_title"
    t.string   "job_unit"
    t.text     "address"
    t.text     "billing_address"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["expired_at"], name: "index_users_on_expired_at", using: :btree
  add_index "users", ["last_activity_at"], name: "index_users_on_last_activity_at", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "workings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
