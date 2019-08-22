json.extract! video, :id, :user_id, :user_unique_id, :created_at, :updated_at
json.url video_url(video, format: :json)
