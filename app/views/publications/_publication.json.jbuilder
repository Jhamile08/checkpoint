json.extract! publication, :id, :title, :category, :description, :created_at, :updated_at
json.url publication_url(publication, format: :json)
