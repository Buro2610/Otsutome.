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

ActiveRecord::Schema[7.0].define(version: 2023_06_04_060705) do
  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preference_levels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "color_id", null: false
    t.integer "order"
    t.index ["color_id"], name: "index_preference_levels_on_color_id"
    t.index ["name"], name: "index_preference_levels_on_name", unique: true
  end

  create_table "shift_preferences", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "time_slot_id", null: false
    t.integer "preference_level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["preference_level_id"], name: "index_shift_preferences_on_preference_level_id"
    t.index ["time_slot_id"], name: "index_shift_preferences_on_time_slot_id"
    t.index ["user_id"], name: "index_shift_preferences_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otsutome_title"
    t.index ["user_id", "created_at"], name: "index_shifts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_shifts_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.integer "task_id", null: false
    t.integer "user_id", null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.string "name", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["name"], name: "index_time_slots_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "position_title"
    t.text "possible_task"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "preference_levels", "colors"
  add_foreign_key "shift_preferences", "preference_levels"
  add_foreign_key "shift_preferences", "time_slots"
  add_foreign_key "shift_preferences", "users"
  add_foreign_key "shifts", "users"
  add_foreign_key "tasks", "users"
end
