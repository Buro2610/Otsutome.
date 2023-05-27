class RemoveColorFromPreferenceLevels < ActiveRecord::Migration[7.0]
  def change
    remove_column :preference_levels, :color, :string
  end
end
