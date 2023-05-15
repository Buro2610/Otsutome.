class AddPositionTitleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :position_title, :string
  end
end
