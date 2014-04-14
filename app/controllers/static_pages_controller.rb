class StaticPagesController < ApplicationController
  def home
    @coaches = Coach.all.shuffle[0..5]
  end

  def about
  end

  def contact
  end
end
