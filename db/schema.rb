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

ActiveRecord::Schema.define(version: 20170926180836) do

  create_table "ahoy_messages", force: :cascade do |t|
    t.string   "token"
    t.text     "to"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "mailer"
    t.text     "subject"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.index ["token"], name: "index_ahoy_messages_on_token"
    t.index ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type"
  end

  create_table "beta_signups", force: :cascade do |t|
    t.string   "email",              null: false
    t.integer  "utm_attribution_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["utm_attribution_id"], name: "index_beta_signups_on_utm_attribution_id"
  end

  create_table "court_case_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "case_number",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "advocate_email"
    t.string   "dda_email"
    t.index ["user_id"], name: "index_court_case_subscriptions_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feedback_responses", force: :cascade do |t|
    t.integer  "value",              null: false
    t.text     "body"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "page"
    t.integer  "utm_attribution_id"
    t.index ["utm_attribution_id"], name: "index_feedback_responses_on_utm_attribution_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "first_name"
    t.string   "offender_sid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "offender_search_caches", force: :cascade do |t|
    t.integer  "offender_sid"
    t.text     "data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["offender_sid"], name: "index_offender_search_caches_on_offender_sid", unique: true
  end

  create_table "rights", force: :cascade do |t|
    t.string  "name",                       null: false
    t.integer "court_case_subscription_id", null: false
    t.index ["court_case_subscription_id"], name: "index_rights_on_court_case_subscription_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "utm_attributions", force: :cascade do |t|
    t.string   "utm_source"
    t.string   "utm_content"
    t.string   "utm_medium"
    t.string   "utm_campaign"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
