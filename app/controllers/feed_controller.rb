class FeedController < ApplicationController
  before_action :set_materials, :set_courses

  def index
  end
  

  
  private
  
    def set_materials
      @feed_materials = Material.all
    end

    def set_courses
      @feed_courses = Course.all
    end
end
