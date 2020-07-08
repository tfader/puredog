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

ActiveRecord::Schema.define(version: 2020_07_08_064014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attr_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value_type", default: 0
  end

  create_table "attrs", force: :cascade do |t|
    t.bigint "attr_class_id"
    t.string "name"
    t.integer "value_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attr_class_id"], name: "index_attrs_on_attr_class_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "default", default: 0
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.string "street"
    t.string "code"
    t.index ["city_id"], name: "index_clients_on_city_id"
  end

  create_table "employee_spots", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "spot_id"
    t.date "date_from"
    t.date "date_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_spots_on_employee_id"
    t.index ["spot_id"], name: "index_employee_spots_on_spot_id"
  end

  create_table "employee_users", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_users_on_employee_id"
    t.index ["user_id"], name: "index_employee_users_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.integer "active", default: 1
  end

  create_table "exam_attrs", force: :cascade do |t|
    t.bigint "attr_id"
    t.integer "mandatory", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attr_id"], name: "index_exam_attrs_on_attr_id"
  end

  create_table "exam_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exam_units", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "unit_id"
    t.integer "is_default", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_units_on_exam_id"
    t.index ["unit_id"], name: "index_exam_units_on_unit_id"
  end

  create_table "exam_varieties", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "variety_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_varieties_on_exam_id"
    t.index ["variety_id"], name: "index_exam_varieties_on_variety_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "material_id"
    t.bigint "exam_group_id"
    t.string "description"
    t.index ["exam_group_id"], name: "index_exams_on_exam_group_id"
    t.index ["material_id"], name: "index_exams_on_material_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parameters", force: :cascade do |t|
    t.string "param_name"
    t.string "param_value"
    t.string "value_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_attr_values", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "attr_id"
    t.string "attr_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attr_id"], name: "index_patient_attr_values_on_attr_id"
    t.index ["patient_id"], name: "index_patient_attr_values_on_patient_id"
  end

  create_table "patient_attrs", force: :cascade do |t|
    t.bigint "attr_id"
    t.integer "mandatory", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attr_id"], name: "index_patient_attrs_on_attr_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "variety_id"
    t.bigint "patron_id"
    t.index ["patron_id"], name: "index_patients_on_patron_id"
    t.index ["variety_id"], name: "index_patients_on_variety_id"
  end

  create_table "patrons", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_spots_on_city_id"
  end

  create_table "unit_rates", force: :cascade do |t|
    t.integer "from_unit_id"
    t.integer "to_unit_id"
    t.integer "rate_from", default: 1
    t.integer "rate_to", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_unit_id"], name: "index_unit_rates_on_from_unit_id"
    t.index ["to_unit_id"], name: "index_unit_rates_on_to_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "varieties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_icon"
  end

  add_foreign_key "attrs", "attr_classes"
  add_foreign_key "clients", "cities"
  add_foreign_key "employee_spots", "employees"
  add_foreign_key "employee_spots", "spots"
  add_foreign_key "employee_users", "employees"
  add_foreign_key "employee_users", "users"
  add_foreign_key "exam_attrs", "attrs"
  add_foreign_key "exam_units", "exams"
  add_foreign_key "exam_units", "units"
  add_foreign_key "exam_varieties", "exams"
  add_foreign_key "exam_varieties", "varieties"
  add_foreign_key "exams", "exam_groups"
  add_foreign_key "exams", "materials"
  add_foreign_key "patient_attr_values", "attrs"
  add_foreign_key "patient_attr_values", "patients"
  add_foreign_key "patient_attrs", "attrs"
  add_foreign_key "patients", "patrons"
  add_foreign_key "patients", "varieties"
  add_foreign_key "spots", "cities"
end
