json.extract! user, :id, :name, :total_score, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
