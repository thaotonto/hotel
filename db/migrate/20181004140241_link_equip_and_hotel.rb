class LinkEquipAndHotel < ActiveRecord::Migration[5.2]
  def change
    create_table :hotel_equips do |t|
      t.references :motel, foreign_key: true
      t.references :equipment, foreign_key: true
      t.string :price

      t.timestamps
    end

    add_index :hotel_equips, [:motel_id, :equipment_id], unique: true
  end
end
