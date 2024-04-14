# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_14_110138) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "accounts", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "email", default: "", null: false
    t.boolean "employee", default: false, null: false
    t.integer "accountable_id"
    t.string "accountable_type"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable_type_and_accountable_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "car_categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_car_categories_on_name", unique: true
  end

  create_table "car_makes", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "car_category_id"
    t.index ["car_category_id"], name: "index_car_makes_on_car_category_id"
    t.index ["name", "car_category_id"], name: "index_car_makes_on_name_and_car_category_id", unique: true
  end

  create_table "car_models", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "car_make_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_make_id"], name: "index_car_models_on_car_make_id"
    t.index ["name", "car_make_id"], name: "index_car_models_on_name_and_car_make_id", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", default: ""
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "address"
    t.string "phone", default: ""
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location"], name: "index_clients_on_location", using: :gist
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_token"
    t.string "device_id", null: false
    t.integer "platform", default: 0, null: false
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_devices_on_account_id"
    t.index ["device_id", "platform", "account_id"], name: "index_devices_on_device_id_and_platform_and_account_id", unique: true
    t.index ["device_token", "device_id"], name: "index_devices_on_device_token_and_device_id", unique: true, where: "(device_token IS NOT NULL)"
  end

  create_table "model_years", force: :cascade do |t|
    t.integer "year", null: false
    t.bigint "car_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_model_id"], name: "index_model_years_on_car_model_id"
    t.index ["year", "car_model_id"], name: "index_model_years_on_year_and_car_model_id", unique: true
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "service_request_id", null: false
    t.bigint "shop_id", null: false
    t.decimal "budget", precision: 10, scale: 2, null: false
    t.string "description"
    t.boolean "accepted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "paid", precision: 10, scale: 2, default: "0.0"
    t.index ["service_request_id", "shop_id"], name: "index_offers_on_service_request_id_and_shop_id", unique: true
    t.index ["service_request_id"], name: "index_offers_on_service_request_id"
    t.index ["shop_id"], name: "index_offers_on_shop_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "data"
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable"
  end

  create_table "promo_codes", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "email", null: false
    t.string "code_token"
    t.datetime "activated_at"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_promo_codes_on_shop_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.bigint "offer_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_ratings_on_client_id"
    t.index ["offer_id"], name: "index_ratings_on_offer_id", unique: true
  end

  create_table "service_requests", force: :cascade do |t|
    t.text "summary", default: "", null: false
    t.string "title", default: "", null: false
    t.decimal "estimated_budget", precision: 10, scale: 2
    t.integer "category", default: 0, null: false
    t.bigint "vehicle_id"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.string "address", default: "", null: false
    t.boolean "evacuation", default: false, null: false
    t.boolean "repair_parts", default: false, null: false
    t.datetime "schedule_service"
    t.string "vin"
    t.integer "radius"
    t.integer "mileage"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location"], name: "index_service_requests_on_location", using: :gist
    t.index ["vehicle_id"], name: "index_service_requests_on_vehicle_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "owner_name", default: "", null: false
    t.string "hours_of_operation", default: "", null: false
    t.integer "techs_per_shift", default: 0, null: false
    t.boolean "certified", default: false
    t.boolean "lounge_area", default: false, null: false
    t.boolean "supervisor_permanently", default: false, null: false
    t.text "languages", default: [], array: true
    t.boolean "tow_track", default: false
    t.boolean "complimentary_inspection", default: false, null: false
    t.boolean "vehicle_diesel", default: false
    t.boolean "vehicle_electric", default: false
    t.boolean "vehicle_warranties", default: false, null: false
    t.integer "categories", default: [], null: false, array: true
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.string "address", default: "", null: false
    t.string "phone", default: "", null: false
    t.boolean "approved", default: false, null: false
    t.string "avatar"
    t.text "additional_info"
    t.decimal "average_rating", precision: 3, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approved"], name: "index_shops_on_approved"
    t.index ["categories"], name: "index_shops_on_categories", using: :gin
    t.index ["location"], name: "index_shops_on_location", using: :gist
    t.index ["name"], name: "index_shops_on_name", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make", default: "", null: false
    t.string "model", default: "", null: false
    t.integer "year", default: 0, null: false
    t.string "category", default: "", null: false
    t.string "string", default: "", null: false
    t.bigint "client_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_vehicles_on_client_id"
  end

  add_foreign_key "car_makes", "car_categories", on_delete: :cascade
  add_foreign_key "car_models", "car_makes", on_delete: :cascade
  add_foreign_key "devices", "accounts", on_delete: :cascade
  add_foreign_key "model_years", "car_models", on_delete: :cascade
  add_foreign_key "ratings", "clients", on_delete: :nullify
  add_foreign_key "ratings", "offers", on_delete: :cascade
  add_foreign_key "service_requests", "vehicles", on_delete: :cascade
  add_foreign_key "vehicles", "clients", on_delete: :cascade
end
