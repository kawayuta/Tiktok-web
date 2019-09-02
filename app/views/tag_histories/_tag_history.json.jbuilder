json.extract! tag_history, :id, :user_official_id, :user_nick_named, :created_at, :updated_at
json.url tag_history_url(tag_history, format: :json)
