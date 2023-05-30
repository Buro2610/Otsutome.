class ShiftsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, except: [:index]
  before_action :set_user, only: [:index, :create, :new, :edit, :update, :destroy]
  before_action :set_shift, only: [:edit, :update, :destroy]
  before_action :set_task_names, only: [:new, :create, :edit, :update]

  def index
    @user = User.find(params[:user_id])
    @shifts = @user.shifts
  end

  def admincalendar
    @users = User.all
    @allshifts = Shift.all
  end

  def create
    @user = User.find(params[:user_id])
    @shift = @user.shifts.build(shift_params)
    if @shift.save
      flash[:success] = "シフトが作成されました！"
      # Check the HTTP_REFERER and redirect accordingly
      if request.referer.include?('admin')
        redirect_to calendar_admin_path
      else
        redirect_to user_shifts_path(@user)
      end
    else
      flash.now[:danger] = @shift.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def new
    @user = User.find(params[:user_id])
    @default_date = params[:date]&.to_date || Date.today
    start_time = Time.parse(params[:start_time]) || @default_date.beginning_of_day
    end_time = Time.parse(params[:end_time]) || @default_date.end_of_day
    @shift = @user.shifts.new(start_time: start_time.change(year: @default_date.year, month: @default_date.month, day: @default_date.day), end_time: end_time.change(year: @default_date.year, month: @default_date.month, day: @default_date.day))
  end

  def edit
    @user = User.find(params[:user_id])
    @shift = @user.shifts.find(params[:id])
    @default_date = params[:default_date]&.to_date || Date.today
  end


  def update
    if @shift.update(shift_params)
      flash[:success] = "シフトが更新されました！"
      redirect_to calendar_admin_path
    else
      flash[:danger] = @shift.errors.full_messages.join(", ")
      @default_date = params[:default_date]&.to_date || Date.today
      render 'edit', object: @shift, status: :unprocessable_entity
    end
  end

  def destroy
    if @shift.destroy
      flash[:success] = "シフトを削除しました"
    else
      flash[:danger] = "シフトの削除に失敗しました"
      flash[:error] = @shift.errors.full_messages.join(", ")
    end
  end


  private

  def shift_params
    params.require(:shift).permit(:otsutome_title, :start_time, :end_time, :possible_task)
  end

  def set_task_names
    @task_names = User.find_by(admin: true)&.tasks&.pluck(:name)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shift
    @shift = @user.shifts.find(params[:id])
  end

  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end

end
