class AddColorToPreferenceLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :preference_levels, :color, :string
  end
end
