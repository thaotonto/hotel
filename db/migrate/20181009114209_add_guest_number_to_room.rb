class AddGuestNumberToRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :guest_no, :integer, default: 1
  end
end
