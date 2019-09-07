json.extract! user_history, :id, :user_official_id, :user_nick_named, :created_at, :updated_at
json.url user_history_url(user_history, format: :json)
