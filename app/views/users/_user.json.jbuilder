json.extract! user, :id, :user_official_id, :user_nick_named, :created_at, :updated_at
json.url user_url(user, format: :json)
