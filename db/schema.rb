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

ActiveRecord::Schema.define(version: 2020_01_14_125429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "activities_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "activity_id", null: false
    t.index ["activity_id"], name: "index_activities_users_on_activity_id"
    t.index ["user_id"], name: "index_activities_users_on_user_id"
  end

  create_table "actualities", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "space_id", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_actualities_on_admin_id"
    t.index ["space_id"], name: "index_actualities_on_space_id"
  end

  create_table "call_for_ideas", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "type_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_call_for_ideas_on_project_id"
    t.index ["type_id"], name: "index_call_for_ideas_on_type_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.text "pos_body", default: "Write your very nice comment here..."
    t.text "neg_body", default: "And here the others"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "space_id", null: false
    t.bigint "type_id", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.boolean "ready", default: false
    t.bigint "call_for_idea_id"
    t.boolean "on", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "file"
    t.index ["admin_id"], name: "index_ideas_on_admin_id"
    t.index ["call_for_idea_id"], name: "index_ideas_on_call_for_idea_id"
    t.index ["space_id"], name: "index_ideas_on_space_id"
    t.index ["type_id"], name: "index_ideas_on_type_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.text "message"
    t.boolean "accepted", default: false, null: false
    t.boolean "declined", default: false, null: false
    t.string "password_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["password_token"], name: "index_invitations_on_password_token", unique: true
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "options_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "option_id", null: false
    t.index ["option_id"], name: "index_options_users_on_option_id"
    t.index ["user_id"], name: "index_options_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "space_id", null: false
    t.string "name"
    t.text "description"
    t.bigint "type_id", null: false
    t.datetime "deadline", null: false
    t.boolean "ready", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_projects_on_admin_id"
    t.index ["space_id"], name: "index_projects_on_space_id"
    t.index ["type_id"], name: "index_projects_on_type_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "name"
    t.boolean "mcq"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.bigint "admin_id"
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.boolean "private", default: false
    t.boolean "discoverable", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_spaces_on_admin_id"
  end

  create_table "spaces_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "space_id", null: false
    t.index ["space_id"], name: "index_spaces_users_on_space_id"
    t.index ["user_id"], name: "index_spaces_users_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "space_id", null: false
    t.bigint "type_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "end_date"
    t.boolean "ready", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_surveys_on_admin_id"
    t.index ["space_id"], name: "index_surveys_on_space_id"
    t.index ["type_id"], name: "index_surveys_on_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.datetime "birthdate", default: "2020-01-15 11:53:22", null: false
    t.string "address", default: "", null: false
    t.string "gender", default: "undefined", null: false
    t.bigint "main_space_id"
    t.bigint "language_id", default: 1
    t.string "role", default: "citizen"
    t.boolean "admin", default: false
    t.boolean "super_admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["language_id"], name: "index_users_on_language_id"
    t.index ["main_space_id"], name: "index_users_on_main_space_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "viewers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "idea", default: false
    t.boolean "survey", default: false
    t.boolean "project", default: false
    t.boolean "call_for_idea", default: false
    t.boolean "actuality", default: false
    t.integer "wys_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_viewers_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "actualities", "spaces"
  add_foreign_key "ideas", "spaces"
  add_foreign_key "ideas", "types"
  add_foreign_key "options", "questions"
  add_foreign_key "projects", "spaces"
  add_foreign_key "projects", "types"
  add_foreign_key "questions", "surveys"
  add_foreign_key "surveys", "spaces"
  add_foreign_key "surveys", "types"
  add_foreign_key "viewers", "users"
end
