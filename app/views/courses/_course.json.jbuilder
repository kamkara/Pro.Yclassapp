json.extract! course, :id, :title, :content, :level_name, :material_name, :slug, :statut_name, :user_id, :created_at, :updated_at
json.url course_url(course, format: :json)
json.content course.content.to_s
