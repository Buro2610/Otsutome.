class CreateTimeSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :time_slots do |t|
      t.string :name, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end

    add_index :time_slots, :name, unique: true
  end
end
