# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_527_032_828) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'addresses', force: :cascade do |t|
    t.string 'street'
    t.string 'city', null: false
    t.string 'state', null: false
    t.string 'zip', null: false
    t.integer 'addressable_id'
    t.string 'addressable_type'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'chefs', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.integer 'age'
    t.integer 'years_of_pro_experience'
    t.integer 'years_of_am_experience'
    t.text 'self_description', null: false
    t.text 'unavailable'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'password_digest', null: false
    t.string 'specialty', null: false
    t.integer 'travel_distance'
    t.boolean 'email_confirmed', default: false
    t.string 'confirm_token'
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.boolean 'email_confirmed', default: false, null: false
    t.string 'confirm_token'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
end
