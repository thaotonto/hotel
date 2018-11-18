class CreateEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment do |t|
      t.string :name

      t.timestamps
    end
    add_index :equipment, :name, unique: true
  end
end
