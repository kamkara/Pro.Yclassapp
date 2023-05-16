class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          ############### RELATIONS ####################
  has_many :courses
  has_many :levels
  has_many :materials
  has_many :statuts
  has_many :learns
  has_many :exercises
  has_many :questions
  has_many :results
  has_many :articles


   # Avant la validation de l'utilisateur, assigner first_name et last_name à partir de full_name
  before_validation :assign_names_from_full_name
  
  # Avant de sauvegarder l'utilisateur, mettre en majuscule la première lettre de chaque nom
  before_save :capitalize_names


  # Valide que les noms ont été assignés
  validates :first_name, presence: { message: "Le nom est obligatoire" }
  validates :last_name, presence: { message: "Le prénom est obligatoire" }


  private

  def assign_names_from_full_name
    # Vérifie si le full_name est renseigné
    return if self.full_name.blank?

    # Sépare le full_name en mots individuels
    name_parts = self.full_name.split(" ")

    # Le dernier mot est le last_name
    self.last_name = name_parts.pop

    # Les mots restants sont le first_name
    self.first_name = name_parts.join(" ")

    # Retourne les valeurs de first_name et last_name
    return self.first_name, self.last_name

    # Vérifie que les noms ont été assignés
    unless self.first_name.present? && self.last_name.present?
      errors.add(:full_name, "Le nom et le prénom sont obligatoires")
    end
  end

  def capitalize_names
    # Met en majuscule la première lettre de chaque nom
    self.full_name = self.full_name.split.map(&:capitalize).join(' ')
    self.first_name  = self.first_name.split.map(&:capitalize).join(' ')
    self.last_name = self.last_name.capitalize
  end
  
end
