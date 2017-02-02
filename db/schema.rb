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

ActiveRecord::Schema.define(version: 20170202125947) do

  create_table "comments", force: :cascade do |t|
    t.string   "user_name"
    t.text     "comment"
    t.datetime "date_time"
    t.integer  "product_id"
  end

  create_table "shoes", force: :cascade do |t|
    t.string  "shoes_name"
    t.text    "description"
    t.float   "price"
    t.integer "product_id"
    t.float   "size_min"
    t.float   "size_max"
    t.string  "color"
    t.string  "gender"
    t.integer "amount"
    t.string  "category"
  end

  create_table "tops", force: :cascade do |t|
    t.string  "top_name"
    t.text    "description"
    t.float   "price"
    t.integer "product_id"
    t.float   "size"
    t.float   "color"
    t.string  "gender"
    t.integer "amount"
    t.string  "category"
  end

  create_table "users", force: :cascade do |t|
    t.string  "user_name"
    t.string  "salt"
    t.string  "password_hash"
    t.boolean "admin"
  end

end
