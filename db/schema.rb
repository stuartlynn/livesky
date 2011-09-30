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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110921162545) do

  create_table "annotations", :force => true do |t|
    t.integer  "classification_id"
    t.integer  "task_id"
    t.integer  "answer_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "x"
    t.float    "y"
    t.float    "width"
    t.float    "height"
    t.integer  "marker_id"
    t.boolean  "has_extra_data"
    t.string   "add_type"
  end

  add_index "annotations", ["answer_id"], :name => "answer_id_index"
  add_index "annotations", ["classification_id"], :name => "classification_id_index"
  add_index "annotations", ["task_id"], :name => "task_id_index"

  create_table "answers", :force => true do |t|
    t.string   "value"
    t.text     "details"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["task_id"], :name => "task_id_index"

  create_table "classifications", :force => true do |t|
    t.integer  "light_curve_id"
    t.integer  "zooniverse_user_id"
    t.integer  "workflow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started"
    t.datetime "ended"
    t.string   "application_identifier"
    t.string   "session_id"
  end

  add_index "classifications", ["created_at"], :name => "created_at_index"
  add_index "classifications", ["light_curve_id"], :name => "light_curve_id_index"
  add_index "classifications", ["zooniverse_user_id"], :name => "zooniverse_user_id_index"

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "light_curve_id"
    t.integer  "zooniverse_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discoveries", :force => true do |t|
    t.integer  "source_id"
    t.string   "discovery_type"
    t.boolean  "confirmed",                                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "first_seen",     :precision => 5, :scale => 1
    t.float    "planet_radius"
    t.float    "planet_period"
    t.text     "comments"
    t.integer  "version",                                      :default => 1
  end

  add_index "discoveries", ["discovery_type"], :name => "descovery_type_index"
  add_index "discoveries", ["first_seen"], :name => "index_discoveries_on_first_seen"
  add_index "discoveries", ["planet_period"], :name => "planet_period_index"
  add_index "discoveries", ["planet_radius"], :name => "planet_radius_index"
  add_index "discoveries", ["source_id"], :name => "source_id_index"

  create_table "favourites", :force => true do |t|
    t.integer  "zooniverse_user_id"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["zooniverse_user_id", "source_id"], :name => "index_favourites_on_zooniverse_user_id_and_source_id"

  create_table "kepler_fovs", :force => true do |t|
    t.float    "ra_1"
    t.float    "dec_1"
    t.float    "ra_2"
    t.float    "dec_2"
    t.float    "ra_3"
    t.float    "dec_3"
    t.float    "ra_4"
    t.float    "dec_4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "light_curves", :force => true do |t|
    t.decimal  "release_id",                                 :precision => 5, :scale => 1
    t.integer  "source_id"
    t.string   "status"
    t.integer  "classification_count"
    t.text     "data",                 :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "start_time"
    t.integer  "junk_count",                                                               :default => 0
    t.integer  "transit_count",                                                            :default => 0
    t.string   "zooniverse_id"
    t.string   "static_image"
    t.string   "thumbnail_image"
    t.string   "light_curve_url"
    t.binary   "processed_fits",       :limit => 11,                                       :default => "false\x00\x00\x00\x00\x00\x00"
    t.binary   "created_file",         :limit => 11,                                       :default => "false\x00\x00\x00\x00\x00\x00"
    t.binary   "uploaded_file",        :limit => 11,                                       :default => "false\x00\x00\x00\x00\x00\x00"
    t.binary   "generated_thumb",      :limit => 11,                                       :default => "false\x00\x00\x00\x00\x00\x00"
    t.binary   "uploaded_thumb",       :limit => 11,                                       :default => "false\x00\x00\x00\x00\x00\x00"
    t.boolean  "priority",                                                                 :default => false
  end

  add_index "light_curves", ["classification_count"], :name => "index_light_curves_on_classification_count"
  add_index "light_curves", ["junk_count"], :name => "index_light_curves_on_junk_count"
  add_index "light_curves", ["release_id", "source_id"], :name => "index_light_curves_on_release_id_and_source_id"
  add_index "light_curves", ["source_id"], :name => "index_light_curves_on_source_id"
  add_index "light_curves", ["static_image"], :name => "index_light_curves_on_static_image"
  add_index "light_curves", ["status"], :name => "index_light_curves_on_status"
  add_index "light_curves", ["transit_count"], :name => "index_light_curves_on_transit_count"
  add_index "light_curves", ["zooniverse_id"], :name => "index_light_curves_on_zooniverse_id", :unique => true

  create_table "sources", :force => true do |t|
    t.string   "kepler_id"
    t.float    "ra"
    t.float    "dec"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "star_type"
    t.string   "spec_type"
    t.float    "eff_temp"
    t.float    "log_g"
    t.float    "stellar_rad"
    t.float    "kepler_mag"
    t.float    "j_mag"
    t.float    "h_mag"
    t.float    "k_mag"
    t.string   "kind",          :default => "candidate"
    t.integer  "kepler_fov_id"
    t.float    "distance"
    t.string   "zooniverse_id"
    t.float    "planet_mass"
    t.float    "planet_period"
  end

  add_index "sources", ["kepler_id"], :name => "index_sources_on_kepler_id"
  add_index "sources", ["spec_type"], :name => "index_sources_on_spec_type"
  add_index "sources", ["star_type"], :name => "index_sources_on_star_type"
  add_index "sources", ["zooniverse_id"], :name => "index_sources_on_zooniverse_id", :unique => true

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_extra_data"
  end

  add_index "tasks", ["name"], :name => "index_tasks_on_name"

  create_table "tolk_locales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tolk_locales", ["name"], :name => "index_tolk_locales_on_name", :unique => true

  create_table "tolk_phrases", :force => true do |t|
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tolk_translations", :force => true do |t|
    t.integer  "phrase_id"
    t.integer  "locale_id"
    t.text     "text"
    t.text     "previous_text"
    t.boolean  "primary_updated", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tolk_translations", ["phrase_id", "locale_id"], :name => "index_tolk_translations_on_phrase_id_and_locale_id", :unique => true

  create_table "workflow_answers", :force => true do |t|
    t.integer  "answer_id"
    t.integer  "workflow_task_id"
    t.integer  "next_workflow_task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workflow_tasks", :force => true do |t|
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "workflow_id"
  end

  create_table "workflows", :force => true do |t|
    t.string   "name"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zooniverse_users", :id => false, :force => true do |t|
    t.string   "name"
    t.string   "role",                 :default => "zooite"
    t.integer  "zooniverse_user_id"
    t.boolean  "notifications"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "classification_count", :default => 0
  end

  add_index "zooniverse_users", ["created_at"], :name => "created_at_index"
  add_index "zooniverse_users", ["updated_at"], :name => "updated_at_index"
  add_index "zooniverse_users", ["zooniverse_user_id"], :name => "index_zooniverse_users_on_zooniverse_user_id", :unique => true

end
