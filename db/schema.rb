# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_18_182258) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.integer "zipcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "photo"
  end

  create_table "activities", force: :cascade do |t|
    t.integer "account_id"
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "annual", default: false
    t.index ["account_id"], name: "index_activities_on_account_id"
  end

  create_table "addendums", force: :cascade do |t|
    t.integer "note_id"
    t.string "addition"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pending?", default: false
    t.index ["note_id"], name: "index_addendums_on_note_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "project_id"
    t.string "title"
    t.string "author"
    t.string "synopsis"
    t.integer "pages"
    t.boolean "completed", default: false
    t.integer "times_read", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_books_on_project_id"
  end

  create_table "dictionaries", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer "dictionary_id"
    t.string "term"
    t.string "entry_info"
    t.string "more_info"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "topic_tag"
    t.integer "views", default: 0
    t.integer "difficulty", default: 10
    t.index ["dictionary_id"], name: "index_entries_on_dictionary_id"
  end

  create_table "examples", force: :cascade do |t|
    t.integer "entry_id"
    t.string "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "note_id"
    t.integer "addendum_id"
    t.index ["addendum_id"], name: "index_examples_on_addendum_id"
    t.index ["entry_id"], name: "index_examples_on_entry_id"
    t.index ["note_id"], name: "index_examples_on_note_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.integer "topic_id"
    t.string "front"
    t.string "back"
    t.integer "views"
    t.integer "difficulty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_flashcards_on_topic_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "project_id"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_id"
    t.integer "quote_id"
    t.integer "addendum_id"
    t.index ["addendum_id"], name: "index_notes_on_addendum_id"
    t.index ["book_id"], name: "index_notes_on_book_id"
    t.index ["project_id"], name: "index_notes_on_project_id"
    t.index ["quote_id"], name: "index_notes_on_quote_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "project_id"
    t.string "title"
    t.string "photo"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_id"
    t.index ["book_id"], name: "index_photos_on_book_id"
    t.index ["project_id"], name: "index_photos_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "account_id"
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "photos"
    t.index ["account_id"], name: "index_projects_on_account_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "text"
    t.string "author"
    t.string "source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entry_id"
    t.integer "book_id"
    t.index ["book_id"], name: "index_quotes_on_book_id"
    t.index ["entry_id"], name: "index_quotes_on_entry_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "number"
    t.string "difficulty"
    t.string "views"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cards"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weblinks", force: :cascade do |t|
    t.integer "project_id"
    t.string "title"
    t.string "url"
    t.string "description"
    t.integer "book_id"
    t.integer "note_id"
    t.integer "addendum_id"
    t.index ["addendum_id"], name: "index_weblinks_on_addendum_id"
    t.index ["book_id"], name: "index_weblinks_on_book_id"
    t.index ["note_id"], name: "index_weblinks_on_note_id"
    t.index ["project_id"], name: "index_weblinks_on_project_id"
  end

end
