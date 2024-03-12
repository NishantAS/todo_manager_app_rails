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

ActiveRecord::Schema[7.1].define(version: 2023_11_12_162442) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "task_groups", id: false, force: :cascade do |t|
    t.string "name", null: false
    t.string "user_name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_name"], name: "index_task_groups_on_name_and_user_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.tsrange "during_time"
    t.string "group_name", null: false
    t.string "user_name", null: false
    t.boolean "private", default: false, null: false
    t.boolean "done", default: false, null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "verified", default: false, null: false
    t.string "default_task_group_name", default: "Default", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "task_groups", "users", column: "user_name", primary_key: "name", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tasks", "task_groups", column: ["group_name", "user_name"], primary_key: ["name", "user_name"], on_update: :cascade, on_delete: :cascade
end
