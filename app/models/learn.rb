class Learn < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates :material_name, presence: { message: "La matiere est obligatoire" }
  validates :level_name, presence: { message: "Le niveau est obligatoire" }
  validates :content, presence: { message: "Le nom est obligatoire" }
  validates :user_id, presence: { message: "Le createur est obligatoire" }
  validates :slug, presence: { message: "Le lien est obligatoire" }

  #Slugged concern
  include ItemsSlugged
end
