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

ActiveRecord::Schema.define(version: 2021_05_22_152501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_roles", force: :cascade do |t|
    t.bigint "contact_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_roles_on_contact_id"
    t.index ["role_id"], name: "index_contact_roles_on_role_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_title"
    t.string "city"
    t.string "state"
  end

  create_table "incident_contacts", force: :cascade do |t|
    t.bigint "incident_id"
    t.bigint "contact_id"
    t.string "title"
    t.index ["contact_id"], name: "index_incident_contacts_on_contact_id"
    t.index ["incident_id"], name: "index_incident_contacts_on_incident_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.string "incident_type"
    t.string "description"
    t.string "location"
    t.datetime "start_date"
    t.datetime "close_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "state"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contact_roles", "contacts"
  add_foreign_key "contact_roles", "roles"
  add_foreign_key "incident_contacts", "contacts"
  add_foreign_key "incident_contacts", "incidents"
end
