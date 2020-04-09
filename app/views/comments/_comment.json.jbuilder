json.extract! comment, :id, :user_id, :idea_id, :project_id, :sub_project_id, :content, :created_at, :updated_at
json.url comment_url(comment, format: :json)
