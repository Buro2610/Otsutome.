class RemoveColorIdFromPreferenceLevels < ActiveRecord::Migration[7.0]
  def change
    remove_column :preference_levels, :color_id
  end
end
