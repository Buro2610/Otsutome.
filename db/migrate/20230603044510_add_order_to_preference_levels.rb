class AddOrderToPreferenceLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :preference_levels, :order, :integer
  end
end
