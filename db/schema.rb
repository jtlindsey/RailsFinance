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

ActiveRecord::Schema.define(version: 20150826170212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "type"
    t.string   "name",                         limit: 45
    t.string   "last4",                        limit: 4
    t.string   "status",                                  default: "Open"
    t.integer  "balance_cents",                limit: 8
    t.integer  "credit_limit"
    t.decimal  "interest_rate"
    t.boolean  "favorite",                                default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mortgage_term"
    t.integer  "loan_amount_cents"
    t.integer  "minimum_payment_cents"
    t.integer  "minimum_escrow_payment_cents"
  end

  create_table "budget_items", force: :cascade do |t|
    t.string   "category"
    t.integer  "amount_cents"
    t.string   "period"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "watch",        default: false
    t.integer  "user_id"
    t.string   "budget_type"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_type"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "efile"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "transaction_id"
    t.integer  "user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "date"
    t.string   "payee"
    t.text     "comment"
    t.integer  "amount_cents",            limit: 8
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "transaction_type"
    t.integer  "account_id"
    t.string   "category"
    t.integer  "transfer_ref"
    t.integer  "interest_payment_cents"
    t.integer  "principal_payment_cents"
    t.integer  "payment_amount_cents"
    t.integer  "check_number"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "name",                   default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.integer  "user_id"
    t.inet     "user_ip"
    t.string   "user_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
