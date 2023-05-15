class ShiftsController < ApplicationController

before_action :logged_in_user, only: [:create, :destroy, :update]
before_action :correct_user,   only: [:destroy, :update]

  def create
    @shift = current_user.shifts.build(shift_params)
    if @shift.save
      flash[:success] = "シフトを作成しました！"
      redirect_to calendar_path(@shift.user)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      @default_date = params[:default_date]&.to_date || Date.today
      render 'shifts/new'
    end
  end

def destroy
  puts "Shift id: #{@shift.id}, User id: #{@shift.user.id}"
  user_id = @shift.user.id
  if @shift.destroy
    flash[:success] = "シフトを削除しました"
    puts "Redirecting to calendar_path(#{user_id})"
    redirect_to calendar_path(user_id), status: :see_other
  else
    flash[:danger] = "シフトの削除に失敗しました"
  end


end


  def index
    @shifts = Shift.all
  end

  def new
    @shift = Shift.new
    @default_date = params[:default_date]&.to_date || Date.today
  end

  def edit
    @shift = Shift.find(params[:id])
    @default_date = params[:default_date]&.to_date || Date.today
  end

  def update
    if @shift.update!(shift_params)
      flash[:success] = "シフトが更新されました！"
      redirect_to calendar_path(@shift.user)
    else
      render 'edit', status: :unprocessable_entity
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




  # # フラッシュメッセージを Bootstrap 対応させるための設定
  # add_flash_types :success, :info, :warning, :danger

  # before_action :set_shift, only: %i[edit update destroy]




