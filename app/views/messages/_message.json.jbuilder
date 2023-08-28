json.extract! message, :id, :name, :email, :message, :read, :created_at, :updated_at
json.url message_url(message, format: :json)
