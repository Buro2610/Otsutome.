class AddDateToShiftPreferences < ActiveRecord::Migration[7.0]
  def change
    add_column :shift_preferences, :date, :date
  end
end
