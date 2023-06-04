class AddOrderToTimeSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :time_slots, :order, :integer
  end
end
