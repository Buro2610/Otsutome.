class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
