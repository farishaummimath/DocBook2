# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20180904110903) do

  create_table "appointments", :force => true do |t|
    t.date     "appointment_date"
    t.integer  "department_id"
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bedallocations", :force => true do |t|
    t.integer  "room_id"
    t.integer  "bed_id"
    t.string   "comments"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beds", :force => true do |t|
    t.string   "bed_number"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "contact_number"
    t.string   "email"
    t.string   "gender"
    t.string   "nationality"
    t.string   "qualifications"
    t.string   "experience"
    t.integer  "user_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_records", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.string   "medication_given"
    t.string   "comments"
    t.boolean  "recommended_to_admit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "patient_condition"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "contact_number"
    t.string   "email"
    t.string   "gender"
    t.string   "nationality"
    t.string   "address"
    t.string   "blood_group"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "room_number"
    t.string   "room_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", :force => true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

end
