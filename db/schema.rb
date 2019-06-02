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

ActiveRecord::Schema.define(version: 2019_04_16_134106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodies", force: :cascade do |t|
    t.string "name"
    t.string "material"
    t.integer "length"
    t.integer "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "full_name"
    t.string "passport_data"
    t.string "adds"
    t.string "phone_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drives", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.string "manuf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extendeds", force: :cascade do |t|
    t.boolean "abs"
    t.boolean "heating"
    t.boolean "multim"
    t.boolean "p_sens"
    t.boolean "nav"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "amount"
    t.string "type_of_pay"
    t.string "delivery"
    t.string "colour"
    t.integer "final_price"
    t.integer "extended_id"
    t.integer "customer_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perks", force: :cascade do |t|
    t.boolean "del"
    t.boolean "edit"
    t.boolean "addn"
    t.boolean "edit_root"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "model"
    t.string "exist"
    t.string "image"
    t.float "price"
    t.boolean "fav"
    t.integer "tech_id"
    t.integer "body_id"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teches", force: :cascade do |t|
    t.integer "num_of_doors"
    t.integer "num_of_place"
    t.string "loc_of_engine"
    t.string "mspeed"
    t.string "racing"
    t.string "way_res"
    t.integer "drive_id"
    t.integer "transmission_id"
    t.integer "typeng_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transmissions", force: :cascade do |t|
    t.string "name"
    t.string "gears"
    t.string "diff"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "typengs", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.string "material"
    t.integer "cyls"
    t.float "val_engine"
    t.float "power"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "perk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
