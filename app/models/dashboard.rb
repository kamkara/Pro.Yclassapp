class Dashboard < ApplicationRecord
    
    #refactory order items
    scope :student, -> { where("status = ?", "Student").order("created_at desc")}
    scope :daily_sign_up, -> { where("created_at >= ?", Time.zone.now.beginning_of_day)}
end
