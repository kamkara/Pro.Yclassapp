class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception, prepend: true

    include DeviseWhitelist

    before_action  :set_materials, :set_levels

    #After sign in
    def after_sign_in_path_for(resource)
        root_path
    end
    
    def after_sign_up_path_for(resource)
        root_path
    end
    def after_sign_out_path_for(resource)
        root_path
    end
    
    private

        def set_materials
            @materials = Material.all
        end

        def set_levels
            @levels = Level.all
        end
end
