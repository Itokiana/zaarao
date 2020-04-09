json.extract! viewer, :id, :user_id, :idea_id, :survey_id, :project_id, :actuality_id, :created_at, :updated_at
json.url viewer_url(viewer, format: :json)
