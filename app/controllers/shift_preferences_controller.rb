class ShiftPreferencesController < ApplicationController
  before_action :set_shift_preference, only: [:edit, :update, :destroy]

  def index
    @shift_preferences = ShiftPreference.all
  end

  def new
    @shift_preference = ShiftPreference.new
    @preference_level_names = PreferenceLevel.pluck(:name)
    @time_slots = TimeSlot.all
    @preference_levels = PreferenceLevel.all
  end

  def create
    @shift_preferences = params[:shift_preference][:shift_preferences].to_unsafe_h.values.map do |sp|
      time_slot = TimeSlot.find(sp["time_slot_id"])
      current_user.shift_preferences.build(sp.slice("time_slot_id", "preference_level_id").merge(datetime: time_slot.start_time))
    end

    if @shift_preferences.all?(&:save)
      flash[:success] = "希望時間が作成されました！"
      redirect_to shift_preferences_path
    else
      render 'new'
    end
  end



  def edit
  end

  def update
    if @shift_preference.update(shift_preference_params)
      flash[:success] = "希望時間が更新されました！"
      redirect_to shift_preferences_path # ここは適切なリダイレクト先に変更してください
    else
      render :edit
    end
  end

  def destroy
    @shift_preference.destroy
    flash[:success] = "希望時間が削除されました"
    redirect_to shift_preferences_path # ここは適切なリダイレクト先に変更してください
  end

  def start_time
    time_slot.start_time
  end

  private

  def set_shift_preference
    @shift_preference = ShiftPreference.find(params[:id])
  end

  def shift_preference_params
    params.require(:shift_preference).permit(:user_id, :datetime, time_slots_attributes: [:start_time, :end_time, :preference_level_name])
  end

end
