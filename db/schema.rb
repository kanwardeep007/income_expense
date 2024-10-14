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

ActiveRecord::Schema[8.0].define(version: 2024_10_13_232347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "transaction_type_enum", ["credit", "debit"]

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "statement_transactions", primary_key: ["user_id", "statement_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "statement_id", null: false
  end

  create_table "statements", id: :serial, force: :cascade do |t|
    t.text "title"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "statement_id"
    t.integer "amount"
    t.enum "transaction_type", enum_type: "transaction_type_enum"
    t.timestamptz "settled_timestamp"
    t.timestamptz "updated_at"
    t.timestamptz "created_at"
    t.check_constraint "amount >= 0", name: "amount_non_negative"
  end

  create_table "user_income_statistics", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "month"
    t.integer "year"
    t.integer "disposable_income"
    t.text "income_expenditure_rating"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
  end

  create_table "user_statements", primary_key: ["user_id", "statement_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "statement_id", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.text "middle_name"
    t.date "date_of_birth"
    t.text "email"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"

    t.unique_constraint ["email"], name: "users_email_key"
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "statement_transactions", "statements", name: "statement_transactions_statement_id_fkey"
  add_foreign_key "statement_transactions", "users", name: "statement_transactions_user_id_fkey"
  add_foreign_key "transactions", "statements", name: "transactions_statement_id_fkey"
  add_foreign_key "user_income_statistics", "users", name: "user_income_statistics_user_id_fkey"
  add_foreign_key "user_statements", "statements", name: "user_statements_statement_id_fkey"
  add_foreign_key "user_statements", "users", name: "user_statements_user_id_fkey"
end
