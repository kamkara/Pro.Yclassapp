json.extract! statut, :id, :title, :slug, :user_id, :created_at, :updated_at
json.url statut_url(statut, format: :json)
