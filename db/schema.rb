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

ActiveRecord::Schema.define(:version => 20130612133532) do

  create_table "attachment_categories", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "attachment_job_types", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "attachmentizations", :force => true do |t|
    t.integer  "attachmentable_id"
    t.string   "attachmentable_type"
    t.integer  "through_attachmentable_id"
    t.string   "through_attachmentable_type"
    t.integer  "attachment_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "attachment_category_id"
    t.integer  "attachment_job_type_id"
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "accessible"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"

  create_table "companies", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "positions", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "short_description"
    t.text     "description"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "projects", :force => true do |t|
    t.integer  "company_id"
    t.integer  "client_id"
    t.string   "title"
    t.text     "description"
    t.string   "state"
    t.date     "complete_date"
    t.date     "planned_start_date"
    t.date     "planned_complete_date"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "questions", :force => true do |t|
    t.integer  "questionable_id"
    t.string   "questionable_type"
    t.string   "title"
    t.text     "description"
    t.date     "planned_start_date"
    t.date     "planned_complete_date"
    t.string   "priority"
    t.boolean  "is_complete",           :default => false, :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "staff", :force => true do |t|
    t.integer  "staffable_id"
    t.string   "staffable_type"
    t.integer  "staff_role_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "staff_roles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.string   "title"
    t.text     "description"
    t.date     "planned_start_date"
    t.date     "planned_complete_date"
    t.string   "priority"
    t.boolean  "is_complete",           :default => false, :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "tasks_relations", :id => false, :force => true do |t|
    t.integer "to_task_id"
    t.integer "from_task_id"
  end

  create_table "tcps", :force => true do |t|
    t.integer  "company_id"
    t.integer  "client_id"
    t.string   "title"
    t.text     "description"
    t.string   "state"
    t.date     "complete_date"
    t.date     "planned_start_date"
    t.date     "planned_complete_date"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "userizations", :id => false, :force => true do |t|
    t.integer "userable_id"
    t.string  "userable_type"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.integer  "department_id"
    t.integer  "position_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "email",                                                 :default => "", :null => false
    t.string   "encrypted_password",                                    :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "fullname"
    t.string   "gender"
    t.string   "phone"
    t.text     "about"
    t.date     "date_of_birth"
    t.decimal  "salary",                 :precision => 10, :scale => 0
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
