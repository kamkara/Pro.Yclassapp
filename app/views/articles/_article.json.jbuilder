json.extract! article, :id, :title, :main_image, :content, :material_name, :slug, :user_id, :created_at, :updated_at
json.url article_url(article, format: :json)
json.content article.content.to_s
