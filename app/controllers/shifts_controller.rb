class ShiftsController < ApplicationController

before_action :logged_in_user, only: [:create, :destroy, :update]
before_action :correct_user,   only: [:destroy, :update]

# createアクション
  def create
    @default_date = params[:default_date]&.to_date || Date.today
    shift_params_with_date = shift_params.merge({
      start_time: DateTime.new(@default_date.year, @default_date.month, @default_date.day, shift_params["start_time(4i)"].to_i, shift_params["start_time(5i)"].to_i),
      end_time: DateTime.new(@default_date.year, @default_date.month, @default_date.day, shift_params["end_time(4i)"].to_i, shift_params["end_time(5i)"].to_i)
    })
    @shift = current_user.shifts.build(shift_params_with_date)
    if @shift.save
      flash[:success] = "シフトを作成しました！"
      redirect_to calendar_path(@shift.user)
    else
      @task_names = Task.all.pluck(:name)
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'shifts/new', object: @shift, status: :unprocessable_entity
    end
  end

  def destroy
    puts "Shift id: #{@shift.id}, User id: #{@shift.user.id}"
    user_id = @shift.user.id
    if @shift.destroy
      puts "Redirecting to calendar_path(#{user_id})"
      flash[:success] = "シフトを削除しました"
      redirect_to calendar_path(user_id)
    else
      flash[:danger] = "シフトの削除に失敗しました"
    end
  end


  def index
    @shifts = Shift.all
  end

  # newアクション
  def new
    @task_names = User.find_by(admin: true)&.tasks&.pluck(:name)
    @default_date = params[:default_date]&.to_date || Date.today
    @shift = Shift.new(start_time: @default_date.beginning_of_day, end_time: @default_date.end_of_day)
  end

  def edit
    @task_names = User.find_by(admin: true)&.tasks&.pluck(:name)
    @shift = Shift.find(params[:id])
    @default_date = params[:default_date]&.to_date || Date.today
  end

  def update
    if @shift.update(shift_params) # here change update! to update
      flash[:success] = "シフトが更新されました！"
      redirect_to calendar_path(@shift.user)
    else
      @task_names = User.find_by(admin: true)&.tasks&.pluck(:name)
      @default_date = params[:default_date]&.to_date || Date.today
      render 'edit', object: @shift, status: :unprocessable_entity
    end
  end


  private

  def shift_params
    params.require(:shift).permit(:otsutome_title, :start_time, :end_time, :possible_task)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def correct_user
    @shift = current_user.shifts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @shift.nil?
  end
end




  # フラッシュメッセージを Bootstrap 対応させるための設定
  # add_flash_types :success, :info, :warning, :danger

  # before_action :set_shift, only: %i[edit update destroy]





