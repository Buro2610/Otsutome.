class ShiftsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, except: [:calendar]
  before_action :set_shift, only: [:edit, :update, :destroy]
  before_action :set_task_names, only: [:new, :create, :edit, :update]

  def calendar
    @user = User.find(params[:user_id])
    @shifts = @user.shifts
  end

  def admincalendar
    @users = User.all
    @allshifts = Shift.all
  end

  def create
    @user = User.find(params[:user_id])
    @default_date = params[:default_date]&.to_date || Date.today
    shift_params_with_date = shift_params.merge({
      start_time: DateTime.new(@default_date.year, @default_date.month, @default_date.day, shift_params["start_time(4i)"].to_i, shift_params["start_time(5i)"].to_i),
      end_time: DateTime.new(@default_date.year, @default_date.month, @default_date.day, shift_params["end_time(4i)"].to_i, shift_params["end_time(5i)"].to_i)
    })
    @shift = @user.shifts.build(shift_params_with_date)

    if @shift.save
      flash[:success] = "シフトを作成しました！"
      redirect_to user_shift_path(@shift.user)
    else
      render 'new', object: @shift, status: :unprocessable_entity
    end
  end

  def new
    @user = User.find(params[:user_id])
    @default_date = params[:default_date]&.to_date || Date.today
    start_time = params[:start_time]&.to_time || @default_date.beginning_of_day
    end_time = params[:end_time]&.to_time || @default_date.end_of_day
    @shift = @user.shifts.new(start_time: start_time, end_time: end_time)
  end

  def edit
    @shift = Shift.find(params[:id])
    @default_date = params[:default_date]&.to_date || Date.today
  end

  def update
    if @shift.update(shift_params)
      flash[:success] = "シフトが更新されました！"
      redirect_to user_calendar_path(@shift.user)
    else
      flash[:danger] = @shift.errors.full_messages.join(", ")
      @default_date = params[:default_date]&.to_date || Date.today
      render 'edit', object: @shift, status: :unprocessable_entity
    end
  end

  def destroy
    @shift.destroy
    flash[:success] = "シフトを削除しました"
    redirect_to user_calendar_path(@shift.user)
  end

  private

  def shift_params
    params.require(:shift).permit(:otsutome_title, :start_time, :end_time, :possible_task)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def set_task_names
    @task_names = User.find_by(admin: true)&.tasks&.pluck(:name)
  end

  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
