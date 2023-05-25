class DashboardController < ApplicationController
  before_action :authenticate_user!, :student_unauthorized
  before_action :custom, except: %i[home]
  before_action :team_authorized, only: %i[index export course]

  
  ############# ANALYTICS ###########
  def index
  end

  def index
  end

  ############# EXPORT ###########
  def export
  end
  
  def course
  end
  
  ############# SIGN UP ITEMS ###########
  def student
  end

  def ambassador
  end

  def teacher
  end

  private

  def custom
    @user_list = User.all.ordered
    @student_list = @user_list.student_sign_up
    @ambassador_list = @user_list.ambassador_sign_up
    @teacher_list = @user_list.teacher_sign_up
  end

  def student_unauthorized
    #redirect_to root_path if current_user.user_role == "Student"
  end
    
  def team_authorized
    #redirect_to root_path if current_user.user_role != "Team"
  end

end
