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

  create_table "tags", force: :cascade do |t|
    t.text "tag_official_id"
    t.text "tag_title"
    t.text "tag_text"
    t.text "tag_cover_image"
    t.integer "tag_posts_count"
    t.integer "tag_views_count"
    t.text "tag_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "user_official_id"
    t.text "user_nick_name"
    t.text "user_signature"
    t.text "user_covers"
    t.integer "user_following_count"
    t.integer "user_fans_count"
    t.integer "user_heart_count"
    t.integer "user_video_count"
    t.boolean "user_verified"
    t.text "user_region"
    t.text "user_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.integer "user_id"
    t.text "video_source"
    t.text "video_official_id"
    t.text "video_title"
    t.text "video_tags"
    t.text "video_comment_count"
    t.integer "video_play_count"
    t.integer "video_share_count"
    t.text "video_cover_image"
    t.text "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

end
