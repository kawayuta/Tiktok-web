json.extract! video_history, :id, :user_official_id, :created_at, :updated_at
json.url video_history_url(video_history, format: :json)
