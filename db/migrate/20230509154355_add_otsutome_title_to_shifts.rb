class AddOtsutomeTitleToShifts < ActiveRecord::Migration[7.0]
  def change
    add_column :shifts, :otsutome_title, :string
  end
end
