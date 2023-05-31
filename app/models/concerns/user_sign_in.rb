
module UserSignIn
    extend ActiveSupport::Concern

    included do
################## End Logged  #########
        before_validation :strip_matricule
        attr_writer :logged
    end

    
    ################## LOGGED  #########
    ### Remove space in matricle before set in sign in function
    def strip_matricule
        self.logged = logged.strip.squize("").downcase
    end

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