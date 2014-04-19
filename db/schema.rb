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

ActiveRecord::Schema.define(version: 20140419154147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coaches", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "subject"
    t.string   "location"
    t.string   "self_introduction"
    t.string   "course_introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",               default: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "coaches", ["email"], name: "index_coaches_on_email", unique: true, using: :btree
  add_index "coaches", ["remember_token"], name: "index_coaches_on_remember_token", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer  "group_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["group_id", "student_id"], name: "index_enrollments_on_group_id_and_student_id", unique: true, using: :btree
  add_index "enrollments", ["group_id"], name: "index_enrollments_on_group_id", using: :btree
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "coach_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["coach_id"], name: "index_groups_on_coach_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "student_id"
    t.integer  "coach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["coach_id"], name: "index_messages_on_coach_id", using: :btree
  add_index "messages", ["student_id"], name: "index_messages_on_student_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "content"
    t.integer  "coach_id"
    t.integer  "student_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["created_at"], name: "index_posts_on_created_at", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "group_id"
    t.integer  "student_id"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["group_id"], name: "index_ratings_on_group_id", using: :btree
  add_index "ratings", ["student_id"], name: "index_ratings_on_student_id", using: :btree

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree
  add_index "students", ["remember_token"], name: "index_students_on_remember_token", using: :btree

end
