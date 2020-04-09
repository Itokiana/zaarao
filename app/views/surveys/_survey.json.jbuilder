json.extract! survey, :id, :user_id, :name, :end_date, :created_at, :updated_at
json.url survey_url(survey, format: :json)
