class CreatePreferenceLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :preference_levels do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :preference_levels, :name, unique: true
  end
end

