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

ActiveRecord::Schema[7.0].define(version: 2022_10_13_050021) do
  create_table "assessments", force: :cascade do |t|
    t.string "name"
    t.float "max_score"
    t.date "due_date"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.integer "canvas_id"
    t.integer "canvas_course_id"
  end

  create_table "course_teachers", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_teachers_on_course_id"
    t.index ["teacher_id"], name: "index_course_teachers_on_teacher_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "canvas_id"
    t.integer "enrollment_term_id"
    t.string "uuid"
  end

  create_table "enrolments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrolments_on_course_id"
    t.index ["student_id"], name: "index_enrolments_on_student_id"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "student_id"
    t.integer "assessment_id"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "canvas_student_id"
    t.integer "canvas_id"
    t.integer "canvas_assignment_id"
    t.string "graded_at"
    t.index ["assessment_id"], name: "index_grades_on_assessment_id"
    t.index ["student_id"], name: "index_grades_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "uniID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.datetime "last_canvas_request"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "uniID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

end
