class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :type
      t.integer :bed_numbers, default: 1

      t.timestamps
    end
  end
end
