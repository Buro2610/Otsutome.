class AddColorRefToPreferenceLevels < ActiveRecord::Migration[7.0]
  def change
    add_reference :preference_levels, :color, null: false, foreign_key: true
  end
end
