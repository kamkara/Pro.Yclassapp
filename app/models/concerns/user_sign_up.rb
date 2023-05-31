############### SIGN UP ####################
  #enum :role, student: "student", teacher: "teacher", team: "team", default: "student"
        STATUS = ["plan gratuit", "plan premium"]

        ############## BEFORE VALIDATION #######
        before_validation :user_referal_id
        before_validation :strip_referal_code
        before_validation :strip_contact
        before_validation :build_email_and_password_for_student
        before_validation :assign_names_from_full_name

        ############## VALIDATION #######

        validates :first_name, presence: { message: "Le nom est obligatoire" }
        validates :last_name, presence: { message: "Le prénom est obligatoire" }
        validates :password, presence: { message: "Le mots de passe est obligatoire" }
        validates :email, presence: { message: "L'adresse email est obligatoire" }
        validates :user_role, presence: { message: "Le role de l'utilisateur est obligatoire" }
        validates :city_name, presence: { message: "Le nom de la ville est obligatoire" }
        
        
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

   ################  Build Customs fields ###########
                
    ################  Clean Contact ###########
    def strip_contact
        self.contact = contact.gsub(/\s+/, "")
    end
                
    def build_email_and_password_for_student
        ### When current user's Student ##
        if self.user_role == "Student"
            ### fields can't be blank?
            return if self.matricule.blank?
            ### Remove Space when is here
            self.matricule = matricule.gsub(/\s+/, "")
            
            self.email = "#{self.matricule}@gmail.com" ### Use Matricule to build Email
            self.password = "#{self.contact}"### Use Contact to build password

            ### Retourne les valeurs de first_name et last_name
            return self.email, self.password

            # Vérifie que les noms ont été assignés
            unless self.email.present? && self.password.present?
            errors.add(:email, "L'adresse email est obligatoire")
            errors.add(:password, "Le mot de passe est obligatoire")
            end
        else 
            ### When current user' is not Student, :Team, Teacher and What Ever 
            self.matricule = "#{self.contact}T" ### Use Contact to build Matricule
        end
    end
                
    ########### BUILD FIRST NAME & LAST NAME ##############
    def assign_names_from_full_name
        ### Vérifie si le full_name est renseigné
        return if self.full_name.blank?

            ### Sépare le full_name en mots individuels
            name_parts = self.full_name.split(" ")

            ### Le dernier mot est le last_name
            self.last_name = name_parts.pop

            ### Les mots restants sont le first_name
            self.first_name = name_parts.join(" ")

            ### Retourne les valeurs de first_name et last_name
            return self.first_name, self.last_name

        # Vérifie que les noms ont été assignés
        unless self.first_name.present? && self.last_name.present?
            errors.add(:full_name, "Le nom et le prénom sont obligatoires")
        end
    end

  ########### Slugged concern ###############
  #include UserSignIn
  #include UserSignUp

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
  
  
  ################## REFERAL CODE GEN #########
  ### generate User referral id ex: 12345M
    def user_referal_id
        #self.user_referral_id = "#{SecureRandom.random_number(10**5).to_s.rjust(5,'0') + ('A'..'Z').to_a.sample}".gsub(/\s+/, "")
    end
                
    def strip_referal_code
        #self.referral_code = referral_code.gsub(/\s+/, "") if referral_code.present?
    end

  ################## BEFORE SAVE  #########
    before_save do
        self.full_name      = last_name.strip.squeeze("").downcase.capitalize
        self.first_name     = first_name.strip.squeeze("").downcase.capitalize
        self.last_name      = last_name.strip.squeeze("").downcase.capitalize
        self.city_name      = city_name.downcase.capitalize
        #self.level_name     = level_name.downcase.capitalize
        #self.school_name    = school_name.strip.downcase.capitalize
        #self.class_name     = class_name.downcase.capitalize
        self.contact        = contact.strip.squeeze("")
        self.matricule      = matricule.downcase
    end