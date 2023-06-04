class PreferenceLevelsController < ApplicationController
  before_action :set_preference_level, only: [:edit, :update, :destroy]

  def index
    @preference_levels = PreferenceLevel.all
    @preference_level = PreferenceLevel.new
  end

  def edit
  end

  def update
    if @preference_level.update(preference_level_params)
      flash[:success] = "希望度は正常に更新されました"
      redirect_to tasks_path
    else
      flash.now[:danger] = @preference_level.errors.full_messages.join(", ")
      render :edit
    end
  end

  def create
    @preference_level = PreferenceLevel.new(preference_level_params)
    if @preference_level.save
      flash[:success] = "新しい希望度の項目を作成しました"
      redirect_to tasks_path
    else
      flash[:danger] = @preference_level.errors.full_messages.join(", ")
      redirect_to tasks_path
    end
  end

  def destroy
    @preference_level.destroy
    flash[:success] = "希望度を削除しました"
    redirect_to tasks_path
  end


  # in preference_levels_controller.rb and time_slots_controller.rb
  def update_order
    params[:order].each_with_index do |id, index|
      PreferenceLevel.where(id: id).update_all(order: index + 1)
      # or TimeSlot.where(id: id).update_all(order: index + 1) for TimeSlotsController
    end
    head :ok  # this is a response to Ajax request
  end

  private

  def preference_level_params
    params.require(:preference_level).permit(:name, :color_id)
  end


  def set_preference_level
    @preference_level = PreferenceLevel.find(params[:id])
  end
end
