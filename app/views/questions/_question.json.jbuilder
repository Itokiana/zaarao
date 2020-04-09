json.extract! question, :id, :survey_id, :name, :mcq, :created_at, :updated_at
json.url question_url(question, format: :json)
