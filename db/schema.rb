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

ActiveRecord::Schema.define(version: 20150627012755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string  "type"
    t.string  "name",          limit: 45
    t.string  "last4",         limit: 4
    t.string  "status",                   default: "Open"
    t.integer "balance_cents", limit: 8
    t.integer "credit_limit"
    t.decimal "interest_rate"
  end

  create_table "budget_items", force: :cascade do |t|
    t.string   "category"
    t.integer  "amount_cents"
    t.string   "period"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "watch",        default: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_type"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "date"
    t.string   "payee"
    t.text     "comment"
    t.integer  "amount_cents",     limit: 8
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "transaction_type"
    t.integer  "account_id"
    t.string   "category"
    t.integer  "transfer_ref"
  end

end
