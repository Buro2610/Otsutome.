class CreateShiftPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :shift_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.references :time_slot, null: false, foreign_key: true
      t.references :preference_level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
