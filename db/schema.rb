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

ActiveRecord::Schema.define(version: 2019_09_07_171244) do

  create_table "tag_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
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
    t.index ["tag_cover_image"], name: "index_tag_histories_on_tag_cover_image", type: :fulltext
    t.index ["tag_official_id"], name: "index_tag_histories_on_tag_official_id", type: :fulltext
    t.index ["tag_posts_count"], name: "index_tag_histories_on_tag_posts_count", type: :fulltext
    t.index ["tag_text"], name: "index_tag_histories_on_tag_text", type: :fulltext
    t.index ["tag_title"], name: "index_tag_histories_on_tag_title", type: :fulltext
    t.index ["tag_trending"], name: "index_tag_histories_on_tag_trending"
    t.index ["tag_url"], name: "index_tag_histories_on_tag_url", type: :fulltext
    t.index ["tag_views_count"], name: "index_tag_histories_on_tag_views_count", type: :fulltext
  end

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
    t.index ["tag_cover_image"], name: "index_tags_on_tag_cover_image", type: :fulltext
    t.index ["tag_official_id"], name: "index_tags_on_tag_official_id", type: :fulltext
    t.index ["tag_posts_count"], name: "index_tags_on_tag_posts_count", type: :fulltext
    t.index ["tag_text"], name: "index_tags_on_tag_text", type: :fulltext
    t.index ["tag_title"], name: "index_tags_on_tag_title", type: :fulltext
    t.index ["tag_trending"], name: "index_tags_on_tag_trending"
    t.index ["tag_url"], name: "index_tags_on_tag_url", type: :fulltext
    t.index ["tag_views_count"], name: "index_tags_on_tag_views_count", type: :fulltext
  end

  create_table "user_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "user_official_id"
    t.text "user_unique_id"
    t.text "user_sec_id"
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
    t.index ["user_covers"], name: "index_user_histories_on_user_covers", type: :fulltext
    t.index ["user_fans_count"], name: "index_user_histories_on_user_fans_count", type: :fulltext
    t.index ["user_following_count"], name: "index_user_histories_on_user_following_count", type: :fulltext
    t.index ["user_heart_count"], name: "index_user_histories_on_user_heart_count", type: :fulltext
    t.index ["user_nick_name"], name: "index_user_histories_on_user_nick_name", type: :fulltext
    t.index ["user_official_id"], name: "index_user_histories_on_user_official_id", type: :fulltext
    t.index ["user_region"], name: "index_user_histories_on_user_region", type: :fulltext
    t.index ["user_signature"], name: "index_user_histories_on_user_signature", type: :fulltext
    t.index ["user_url"], name: "index_user_histories_on_user_url", type: :fulltext
    t.index ["user_verified"], name: "index_user_histories_on_user_verified"
    t.index ["user_video_count"], name: "index_user_histories_on_user_video_count", type: :fulltext
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
    t.text "user_unique_id"
    t.text "user_sec_id"
    t.index ["user_covers"], name: "index_users_on_user_covers", type: :fulltext
    t.index ["user_fans_count"], name: "index_users_on_user_fans_count", type: :fulltext
    t.index ["user_following_count"], name: "index_users_on_user_following_count", type: :fulltext
    t.index ["user_heart_count"], name: "index_users_on_user_heart_count", type: :fulltext
    t.index ["user_nick_name"], name: "index_users_on_user_nick_name", type: :fulltext
    t.index ["user_official_id"], name: "index_users_on_user_official_id", type: :fulltext
    t.index ["user_region"], name: "index_users_on_user_region", type: :fulltext
    t.index ["user_signature"], name: "index_users_on_user_signature", type: :fulltext
    t.index ["user_url"], name: "index_users_on_user_url", type: :fulltext
    t.index ["user_verified"], name: "index_users_on_user_verified"
    t.index ["user_video_count"], name: "index_users_on_user_video_count", type: :fulltext
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
    t.index ["video_comment_count"], name: "index_videos_on_video_comment_count", type: :fulltext
    t.index ["video_cover_image"], name: "index_videos_on_video_cover_image", type: :fulltext
    t.index ["video_interaction_count"], name: "index_videos_on_video_interaction_count", type: :fulltext
    t.index ["video_official_id"], name: "index_videos_on_video_official_id", type: :fulltext
    t.index ["video_share_count"], name: "index_videos_on_video_share_count", type: :fulltext
    t.index ["video_tags"], name: "index_videos_on_video_tags", type: :fulltext
    t.index ["video_tags_official_ids"], name: "index_videos_on_video_tags_official_ids", type: :fulltext
    t.index ["video_title"], name: "index_videos_on_video_title", type: :fulltext
    t.index ["video_trending"], name: "index_videos_on_video_trending"
  end

  add_foreign_key "videos", "users"
end
