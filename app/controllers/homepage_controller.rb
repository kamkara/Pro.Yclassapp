class HomepageController < ApplicationController
  def index
    @feed_materials = Material.all
    @feed_courses = Course.all
  end
end
