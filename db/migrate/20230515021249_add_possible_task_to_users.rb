class AddPossibleTaskToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :possible_task, :string
  end
end
