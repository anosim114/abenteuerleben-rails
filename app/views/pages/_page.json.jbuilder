json.extract! page, :id, :url, :content, :created_at, :updated_at
json.url page_url(page, format: :json)
