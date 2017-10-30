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

ActiveRecord::Schema.define(version: 20171025074412) do

  create_table "applicant_result_at_chllenges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "challenges_id"
    t.integer  "applicants_id"
    t.integer  "score"
    t.string   "attachment"
    t.text     "log",           limit: 65535
    t.string   "language"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["applicants_id"], name: "index_applicant_result_at_chllenges_on_applicants_id", using: :btree
    t.index ["challenges_id"], name: "index_applicant_result_at_chllenges_on_challenges_id", using: :btree
  end

  create_table "applicants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challenges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "goal"
    t.text     "information", limit: 65535
    t.string   "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
