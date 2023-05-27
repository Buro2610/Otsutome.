class AddColorIdToPreferenceLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :preference_levels, :color_id, :integer
  end
end
