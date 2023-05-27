class ChangeTimeSlotsStartAndEndToTime < ActiveRecord::Migration[7.0]
  def change
    change_column :time_slots, :start_time, :time
    change_column :time_slots, :end_time, :time
  end
end
