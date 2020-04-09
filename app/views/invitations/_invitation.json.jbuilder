json.extract! invitation, :id, :user_id, :message, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
