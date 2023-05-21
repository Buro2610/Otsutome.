class CreateTimeSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :time_slots do |t|
      t.string :name

      t.timestamps
    end
  end
end
