class StaticPagesController < ApplicationController
  def home
    @shift = current_user.shifts.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end

  def calendar
  end




end
