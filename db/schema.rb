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

ActiveRecord::Schema.define(version: 20170204145337) do

  create_table "comments", force: :cascade do |t|
    t.string   "user_name"
    t.text     "comment"
    t.datetime "date_time"
    t.integer  "product_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.float    "unit_price"
    t.integer  "amount"
    t.float    "total_price"
    t.string   "size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.float    "subtotal"
    t.float    "shipping"
    t.float    "total"
    t.integer  "order_status_id"
    t.string   "user_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
  end

  create_table "products", force: :cascade do |t|
    t.string  "product_name"
    t.text    "description"
    t.float   "price"
    t.integer "product_id"
    t.float   "size_min"
    t.float   "size_max"
    t.string  "size"
    t.string  "color"
    t.string  "gender"
    t.integer "amount"
    t.string  "category"
    t.string  "type"
  end

  create_table "users", force: :cascade do |t|
    t.string  "user_name"
    t.string  "salt"
    t.string  "password_hash"
    t.string  "email"
    t.boolean "admin"
    t.string  "status"
  end

end
