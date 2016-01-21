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

ActiveRecord::Schema.define(version: 20160121030346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "run_script"
  end

  create_table "file_specs", force: :cascade do |t|
    t.string   "name"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "file_specs", ["assignment_id"], name: "index_file_specs_on_assignment_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.string   "author"
    t.integer  "assignment_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "pending",       default: true
    t.text     "output"
  end

  add_index "submissions", ["assignment_id"], name: "index_submissions_on_assignment_id", using: :btree

  create_table "submitted_files", force: :cascade do |t|
    t.binary   "data"
    t.integer  "file_spec_id"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "submitted_files", ["file_spec_id"], name: "index_submitted_files_on_file_spec_id", using: :btree
  add_index "submitted_files", ["submission_id"], name: "index_submitted_files_on_submission_id", using: :btree

  add_foreign_key "file_specs", "assignments"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submitted_files", "file_specs"
  add_foreign_key "submitted_files", "submissions"
end
