class Article < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  has_one_attached :main_image_article do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 300]
  end

  # message: "verifier que votre nom numéro est 10 chiffres"}
  validates :title, length: {minimum:10, maximum:150, message:"Verifiez que le titre n'est pas trop long. la longueur du titre est limité 150 caracteres"}
  validates  :content, :user_id, :slug, presence: true
  
  #Slugged concern
  include ItemsSlugged
end
