
# app/controllers/users/registration_steps.rb

module Users
  class RegistrationSteps < ApplicationController
    include Wicked::Wizard

    steps :platform_message, :user_sign_up, :school_info, , :welcome_message

    def show
        @user = current_user
        case step
        when :platform_message
            render_wizard
        when :user_sign_up
            render_wizard
        when :school_info
            render_wizard
        when :welcome_message
            render_wizard
        end
    end

    def update
        @user = current_user
        case step
        when :platform_message
            @user.update(platform_message_params)
        when :user_sign_up
            @user.update(user_sign_up_params)
        when :school_info
            @user.update(school_info_params)
        end
        render_wizard @user
    end

    private

    def plaform_message_params
        params.require(:user).permit(:level_name)
    end

    def user_sign_up_params
        params.require(:user).permit(:first_name, :last_name, :contact, :gender, :city_name)
    end

    def school_info_params
        params.require(:user).permit(:school_name, :matricule, :class_name)
    end
  end
end
