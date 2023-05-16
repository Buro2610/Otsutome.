class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @shift  = current_user.shifts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end


  def help
  end

  def about
  end

  def contact
  end

  def calendar
    @user = User.find(params[:user_id])
    @shifts = @user.shifts
  end

  def admincalendar
    @users = User.all
    @allshifts = Shift.all
  end





end
