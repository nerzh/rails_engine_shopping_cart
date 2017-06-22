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

ActiveRecord::Schema.define(version: 20160609101446) do

  create_table "shopping_cart_billing_addresses", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "street"
    t.string  "city"
    t.integer "country_id"
    t.string  "zip"
    t.string  "phone"
    t.integer "user_id"
  end

  create_table "shopping_cart_countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "shopping_cart_coupons", force: :cascade do |t|
    t.integer "number"
    t.integer "discount"
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.string  "number"
    t.integer "cvv"
    t.string  "first_name"
    t.string  "last_name"
    t.integer "user_id"
    t.integer "exp_month"
    t.integer "exp_year"
  end

  create_table "shopping_cart_deliveries", force: :cascade do |t|
    t.string  "name"
    t.integer "price", default: 0
  end

  create_table "shopping_cart_order_billing_addresses", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "street"
    t.string  "city"
    t.integer "country_id"
    t.integer "order_id"
    t.string  "zip"
    t.string  "phone"
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.integer "price"
    t.integer "quantity"
    t.integer "product_id"
    t.integer "order_id"
  end

  create_table "shopping_cart_order_shipping_addresses", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "street"
    t.string  "city"
    t.integer "country_id"
    t.integer "order_id"
    t.string  "zip"
    t.string  "phone"
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.string   "aasm_state"
    t.integer  "total_price",    default: 0, null: false
    t.datetime "completed_date"
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.integer  "coupon_id"
    t.integer  "delivery_id"
  end

  create_table "shopping_cart_shipping_addresses", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "street"
    t.string  "city"
    t.integer "country_id"
    t.string  "zip"
    t.string  "phone"
    t.integer "user_id"
  end

end
