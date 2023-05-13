module ApplicationHelper
    #include Pagy::Frontend

    #Onglet Title
    def title
        base_title = "Lnclass Education"
        if @title.nil?
        base_title
        else
        "#{@title} • #{base_title}"
        end
    end

    def app_name
        "Lnclass Education"
    end

    def language
        "fr"
    end
    #site description
    def description
        "Prepa Bac, Comprendre Philosophie."
    end
        
    #Site Keys worlds
    def keywords
        "Tle, Bac, Terminale A1 Terminale A2,2nd C ..."
    end
    
    #Theme color
    def theme_color
        "#020408"      
    end
        
    def tileColor
        "#020408"
    end

    #Enable sign In And Up anywhere
    def resource_name
        :user
    end
  
    def resource
        @resource ||= User.new
    end
    
    def resource_class
        User
    end
    
    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end


    #Flash Messages
    def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "shared/flash/user_flash"
    end
end
