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

ActiveRecord::Schema[7.2].define(version: 2026_07_21_020628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_logs", force: :cascade do |t|
    t.bigint "workout_log_id", null: false
    t.bigint "exercise_id", null: false
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "actual_sets"
    t.integer "actual_reps"
    t.decimal "actual_weight", precision: 5, scale: 2
    t.integer "rir"
    t.index ["exercise_id"], name: "index_exercise_logs_on_exercise_id"
    t.index ["workout_log_id"], name: "index_exercise_logs_on_workout_log_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "sets"
    t.string "reps"
    t.string "weight"
    t.bigint "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "muscle_group"
    t.index ["workout_id"], name: "index_exercises_on_workout_id"
  end

  create_table "gyms", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
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
    t.string "name"
    t.integer "role"
    t.bigint "gym_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["gym_id"], name: "index_users_on_gym_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_logs", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "member_id", null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_workout_logs_on_member_id"
    t.index ["workout_id"], name: "index_workout_logs_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "trainer_id", null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gym_id", null: false
    t.index ["gym_id"], name: "index_workouts_on_gym_id"
    t.index ["member_id"], name: "index_workouts_on_member_id"
    t.index ["trainer_id"], name: "index_workouts_on_trainer_id"
  end

  add_foreign_key "exercise_logs", "exercises"
  add_foreign_key "exercise_logs", "workout_logs"
  add_foreign_key "exercises", "workouts"
  add_foreign_key "users", "gyms"
  add_foreign_key "workout_logs", "users", column: "member_id"
  add_foreign_key "workout_logs", "workouts"
  add_foreign_key "workouts", "gyms"
  add_foreign_key "workouts", "users", column: "member_id"
  add_foreign_key "workouts", "users", column: "trainer_id"
end
