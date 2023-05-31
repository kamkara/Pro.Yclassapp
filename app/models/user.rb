class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :trackable, :authentication_keys => [:logged]

  ############### RELATIONS ####################
  has_many :courses
  has_many :levels
  has_many :materials
  has_many :statuts
  has_many :exercises
  has_many :questions
  has_many :results
  has_many :articles

  STATUS = ["plan gratuit", "plan premium"]
  
  #include UserLogged
  #include UserReferral
  #enum :role, student: "student", teacher: "teacher", team: "team", default: "student"
  
  
  before_validation :strip_custom_data, :strip_fields, :full_name#, :user_referral_id

  
  validates :first_name, :last_name, :full_name, :email, :password,
              :contact, :user_role, :city_name, presence: true

  validates :contact, uniqueness: true, numericality: { only_integer: true }, length: { is:10,
              message: "verifier que votre nom numéro est 10 chiffres"}
 
              
   validates :user_role, inclusion: { in: %w(Student Teacher Team Ambassador),
                    message: "%{value} acces non identifier" }
                    
  #validates :user_referral_id, presence: true,
  #                            uniqueness: true,
  #                            format: { with: /\A[0-9]{5}[A-Z]\z/,
  #                            message: "should be 6 digits and 1 uppercase letter" }
                              
  #validates :referral_code,  format: { with: /\A[0-9]{5}[A-Z]\z/,
  #                            message: "should be 6 digits and 1 uppercase letter" }
                              
  ################  Custom data of User ###########
  def strip_custom_data
    self.contact = contact.gsub(/\s+/, "")
    if self.user_role == "Student"
        self.matricule = matricule.gsub(/\s+/, "")
      self.school_name = school_name.strip.downcase.capitalize
      self.email = "#{self.matricule}@gmail.com"
      self.password = "#{self.contact}"
    else 
        self.matricule = "#{self.contact}"
    end
  end

  #generate User referral id ex: 12345M
  def user_referral_id
    #self.user_referral_id = "#{SecureRandom.random_number(10**5).to_s.rjust(5,'0') + ('A'..'Z').to_a.sample}".gsub(/\s+/, "")
  end

  ################  Contact ###########
  def strip_fields
    #Delete espace into fields
    self.contact = contact.gsub(/\s+/, "")
   # self.referral_code = referral_code.gsub(/\s+/, "") if referral_code.present?
  end


  ################  Full name ###########
  def full_name
    self.full_name = "#{self.first_name} #{self.last_name}" 
  end 

################## SLUG ###############
  extend FriendlyId
  friendly_id :user_slugged, use: :slugged
  
  def user_slugged
    [
      :full_name,
    [:full_name, :contact]
    ]
  end
  ################## END SLUGGED #########

  ################## BEFORE SAVE  #########
  before_save do
    self.contact            = contact.strip.squeeze("")
    self.first_name         = first_name.strip.squeeze("").downcase.capitalize
    self.last_name          = last_name.strip.squeeze("").downcase.capitalize
    self.city_name          = city_name.downcase.capitalize
    self.matricule          = matricule.downcase
  end


  ################## End Logged  #########
      attr_writer :logged

  
  ################## LOGGED  #########
  #permet la connexion avec le matricule
  def logged
    @logged || self.matricule || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (logged = conditions.delete(:logged))
      where(conditions.to_h).where(["lower(email) = :value OR lower(matricule) = :value", { :value => logged.downcase }]).first
    elsif conditions.has_key?(:email) || conditions.has_key?(:matricule)
      where(conditions.to_h).first
    end
  end

end
