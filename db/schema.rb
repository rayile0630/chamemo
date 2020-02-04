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

ActiveRecord::Schema.define(version: 2020_01_30_100355) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "memo_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memo_room_id"], name: "index_favorites_on_memo_room_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "memo_room_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "memo_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memo_room_id"], name: "index_memo_room_comments_on_memo_room_id"
    t.index ["user_id"], name: "index_memo_room_comments_on_user_id"
  end

  create_table "memo_room_posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.integer "role", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "memo_room_id"
    t.index ["memo_room_id"], name: "index_memo_room_posts_on_memo_room_id"
    t.index ["user_id"], name: "index_memo_room_posts_on_user_id"
  end

  create_table "memo_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_memo_rooms_on_category_id"
    t.index ["user_id"], name: "index_memo_rooms_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "introduction"
    t.string "picture"
    t.string "post_a_picture"
    t.string "post_b_picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories", "users"
  add_foreign_key "favorites", "memo_rooms"
  add_foreign_key "favorites", "users"
  add_foreign_key "memo_room_comments", "memo_rooms"
  add_foreign_key "memo_room_comments", "users"
  add_foreign_key "memo_room_posts", "memo_rooms"
  add_foreign_key "memo_room_posts", "users"
  add_foreign_key "memo_rooms", "categories"
  add_foreign_key "memo_rooms", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
end