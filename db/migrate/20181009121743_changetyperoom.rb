class Changetyperoom < ActiveRecord::Migration[5.2]
  def change
    rename_column :rooms, :type, :room_type
    change_column :rooms, :room_type, :string
  end
end
