class StaticPagesController < ApplicationController
  def home
    @coach = Coach.all.shuffle[0..4]
  end

  def about
  end

  def contact
  end
end
