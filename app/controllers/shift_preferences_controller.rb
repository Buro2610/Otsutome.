class ShiftPreferencesController < ApplicationController
  before_action :set_shift_preference, only: [:edit, :update, :destroy]

  def index
    @shift_preferences = current_user.shift_preferences
  end

  def adminindex
    @shift_preferences = ShiftPreference.all
  end


  def adminshift
    @shift_preferences = ShiftPreference.all
  end

  def new
    @shift_preference = ShiftPreference.new
    @time_slots = TimeSlot.all
   @shift_preferences = @time_slots.map do |time_slot|
    date = DateTime.parse(params[:default_date] || Date.today.to_s).beginning_of_day
    start_time = date.change(hour: time_slot.start_time.hour, min: time_slot.start_time.min)
    end_time = date.change(hour: time_slot.end_time.hour, min: time_slot.end_time.min)
    current_user.shift_preferences.build(time_slot: time_slot, start_time: start_time, end_time: end_time)

    end
    @preference_level_names = PreferenceLevel.pluck(:name)
    @preference_levels = PreferenceLevel.all
  end


  def create
     date = ActiveSupport::TimeZone.new("Tokyo").parse(params[:default_date] || Date.today.to_s).beginning_of_day
    @shift_preferences = params[:shift_preferences].to_unsafe_h.values.map do |sp|
      time_slot = TimeSlot.find(sp["time_slot_id"])
      start_time = date.change(hour: time_slot.start_time.hour, min: time_slot.start_time.min)
      end_time = date.change(hour: time_slot.end_time.hour, min: time_slot.end_time.min)
      current_user.shift_preferences.new(sp.slice("time_slot_id", "preference_level_id").merge(start_time: start_time, end_time: end_time))
    end

    if @shift_preferences.all?(&:valid?)
      @shift_preferences.each(&:save!)
      flash[:success] = "希望時間が作成されました！"
      redirect_to shift_preferences_path
    else
      @shift_preference = ShiftPreference.new
      @time_slots = TimeSlot.all
      @shift_preferences = @time_slots.map do |time_slot|
        date = DateTime.parse(shift_preference_params[:default_date] || Date.today.to_s).beginning_of_day
        start_time = date.change(hour: time_slot.start_time.hour, min: time_slot.start_time.min)
        end_time = date.change(hour: time_slot.end_time.hour, min: time_slot.end_time.min)
        current_user.shift_preferences.build(time_slot: time_slot, start_time: start_time, end_time: end_time)
      end
      @preference_level_names = PreferenceLevel.pluck(:name)
      @preference_levels = PreferenceLevel.all

      flash.now[:alert] = @shift_preferences.map { |sp| sp.errors.full_messages }.flatten.join(", ")

      render 'new'
    end
  end


  def destroy
    # シフト希望の日付を取得
    date = @shift_preference.start_time.to_date

    # 特定のユーザーと日付に該当する全てのシフト希望を削除
    current_user.shift_preferences.where(start_time: date.beginning_of_day..date.end_of_day).destroy_all

    flash[:success] = "希望時間が削除されました"
    redirect_to shift_preferences_path
  end



  def start_time
    time_slot.start_time
  end


  def datatable
    respond_to do |format|
      format.json {
        render json: ShiftPreferencesDatatable.new(params)
      }
    end
  end

  private

  def set_shift_preference
    @shift_preference = ShiftPreference.find(params[:id])
  end

  def shift_preference_params
    params.require(:shift_preferences).permit!
    params[:shift_preferences].to_unsafe_h.values.map do |p|
      ActionController::Parameters.new(p).permit(:time_slot_id, :preference_level_id, :default_date, :user_id)
    end
  end


end
