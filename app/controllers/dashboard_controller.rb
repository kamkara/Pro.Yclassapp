require 'csv'

class DashboardController < ApplicationController
  
  before_action :authenticate_user!, :student_unauthorized
  before_action :custom, except: %i[home]
  before_action :team_authorized, only: %i[index export course]
  
  def index
  end
  
  def home
    @LevelList = Level.all.ordered
    @CityList = Citytown.all.ordered
    @MaterialList = Material.all.ordered
    @SchoolList = School.all.ordered
  end
  
  def student
  end

  
  def enseignant
  end
  
  def ambassador
  end
  
  
  def export
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=Export-#{Date.today}.csv"
        #render template: "path/to/export.csv.erb"
      end
    end
  end
  
  def course
    @course_items = Course.all
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=Course_Export-#{Date.today}.csv"
        #render template: "path/to/export.csv.erb"
      end
    end
  end
  
  private

    def custom
      @user_list = User.all.ordered
      @student_list = @user_list.student_sign_up
      @ambassador_list = @user_list.ambassador_sign_up
      @teacher_list = @user_list.teacher_sign_up
    end

    def student_unauthorized
      redirect_to root_path if current_user.user_role == "Student"
    end
    def team_authorized
      redirect_to root_path if current_user.user_role != "Team"
    end
end
