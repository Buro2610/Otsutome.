class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: [:edit, :update, :destroy]

  def index
    @time_slots = TimeSlot.all
    @time_slot = TimeSlot.new
  end

  def edit
  end

  def update
    if @time_slot.update(time_slot_params)
      flash[:success] = "時間割を更新しました"
      redirect_to tasks_path
    else
      flash[:danger] = @time_slot.errors.full_messages.join(", ")
      render :edit
    end
  end

  def create
    @time_slot = TimeSlot.new(time_slot_params)
    if @time_slot.save
      flash[:success] = "新しい時間割を作成しました"
      redirect_to tasks_path
    else
      flash[:danger] = @time_slot.errors.full_messages.join(", ")
      redirect_to tasks_path
    end
  end

  def destroy
    @time_slot.destroy
    flash[:success] = "時間割が削除されました"
    redirect_to tasks_path
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:name, :start_time, :end_time)
  end

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end
end
