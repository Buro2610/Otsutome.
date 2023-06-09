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
    @time_slot.order = TimeSlot.maximum(:order).to_i + 1

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

  def update_order
    params[:order].split(',').each_with_index do |id, index|
      TimeSlot.where(id: id.gsub('time-slot-', '')).update_all(order: index + 1)
    end
    head :ok  # this is a response to Ajax request
  end



  private

  def time_slot_params
    params.require(:time_slot).permit(:name, :start_time, :end_time, :order)
  end

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end
end
