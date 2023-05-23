class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception, prepend: true
    include DeviseWhitelist

    ###########  Before ############
    before_action :set_levels

    #After sign in
    def after_sign_in_path_for(resource)
        if current_user
            feed_path
        else
            root_path
        end
    end
    
    #After Sign up
    def after_sign_up_path_for(resource)
        if user_signed_in
            feed_path
        else
            root_path
        end
    end

    private

        def set_levels
            @levels = Level.all
        end
end
