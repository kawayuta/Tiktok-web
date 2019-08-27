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

ActiveRecord::Schema.define(version: 2019_08_22_232910) do

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "tag_official_id"
    t.text "tag_title"
    t.text "tag_text"
    t.text "tag_cover_image"
    t.text "tag_posts_count"
    t.text "tag_views_count"
    t.text "tag_url"
    t.boolean "tag_trending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "user_official_id"
    t.text "user_nick_name"
    t.text "user_signature"
    t.text "user_covers"
    t.text "user_following_count"
    t.text "user_fans_count"
    t.text "user_heart_count"
    t.text "user_video_count"
    t.boolean "user_verified"
    t.text "user_region"
    t.text "user_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.text "video_url"
    t.text "video_official_id"
    t.text "video_title"
    t.text "video_tags"
    t.text "video_tags_official_ids"
    t.text "video_comment_count"
    t.text "video_share_count"
    t.text "video_interaction_count"
    t.text "video_cover_image"
    t.boolean "video_trending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

end
