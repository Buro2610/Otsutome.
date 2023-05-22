class ShiftPreferencesController < ApplicationController
  before_action :set_shift_preference, only: [:edit, :update, :destroy]

  def index
    @shift_preferences = ShiftPreference.all
  end

def new
  @shift_preference = ShiftPreference.new
  @time_slots = TimeSlot.all
  @shift_preferences = @time_slots.map do |time_slot|
    date = DateTime.parse(params[:default_date] || Date.today.to_s).beginning_of_day
    current_user.shift_preferences.build(time_slot: time_slot, datetime: date)
  end
  @preference_level_names = PreferenceLevel.pluck(:name)
  @preference_levels = PreferenceLevel.all
end


def create
  @shift_preferences = params[:shift_preferences].to_unsafe_h.values.map do |sp|
    date = DateTime.parse(params[:default_date] || Date.today.to_s).beginning_of_day
    time_slot = TimeSlot.find(sp["time_slot_id"])
    datetime = date.change(hour: time_slot.start_time.hour, min: time_slot.start_time.min)
    current_user.shift_preferences.new(sp.slice("time_slot_id", "preference_level_id").merge(datetime: datetime))
  end

  if @shift_preferences.all?(&:valid?)
    @shift_preferences.each(&:save!)
    flash[:success] = "希望時間が作成されました！"
    redirect_to shift_preferences_path
  else
    @shift_preference = ShiftPreference.new
    @preference_level_names = PreferenceLevel.pluck(:name)
    @time_slots = TimeSlot.all
    @preference_levels = PreferenceLevel.all

    # ここで、保存に失敗した理由を flash に設定します。
    flash.now[:alert] = @shift_preferences.map { |sp| sp.errors.full_messages }.flatten.join(", ")

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
      params.require(:shift_preference).permit(shift_preferences: [:time_slot_id, :preference_level_id])
  end


end
