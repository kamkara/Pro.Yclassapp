# Whitelist additional fields for devise User objects.
module DeviseWhitelist
    extend ActiveSupport::Concern

    included do
        # Required to accept fields created outside of devise for profiles.
        before_action :configure_permitted_parameters, if: :devise_controller?
        before_action :store_action
    end


    #Configure permitted parameters
    def configure_permitted_parameters
        #Sign Up account params
        sign_params = [:email, :password, :first_name, :last_name, :full_name, :contact, :matricule,
            :user_role, :gender, :city_name, :level_name, :school_name, :media_name, :material_name,
            :doublant_statut, :doublant_statut, :avatar, :slug, ]

        devise_parameter_sanitizer.permit(:sign_in, keys: [:logged, :password])
        devise_parameter_sanitizer.permit(:sign_up, keys: sign_params )
        devise_parameter_sanitizer.permit(:account_update, keys: sign_params)
    end

    def store_action
        return unless request.get? 
        if (request.path != "/users/sign_in" &&
            request.path != "/users/sign_up" &&
            request.path != "/users/password/new" &&
            request.path != "/users/password/edit" &&
            request.path != "/users/confirmation" &&
            request.path != "/users/sign_out" &&
            !request.xhr?) # don't store ajax calls
            store_location_for(:user, request.fullpath)
        end
    end
end