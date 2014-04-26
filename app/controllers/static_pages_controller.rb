class StaticPagesController < ApplicationController
  def home
    if student_signed_in?
      redirect_to student_path(current_student)
    elsif coach_signed_in?
      redirect_to coach_path(current_coach)
    end
    
    @coaches = Coach.all_cached.shuffle[0..4]
    @stats = Rails.cache.stats.first.last
  end

  def about
  end

  def contact
  end
end
