class StaticPagesController < ApplicationController
  def home
    @coaches = Coach.all.shuffle[0..4]
  end

  def about
  end

  def contact
  end
end
