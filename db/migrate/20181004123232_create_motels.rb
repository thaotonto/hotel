class CreateMotels < ActiveRecord::Migration[5.2]
  def change
    create_table :motels do |t|
      t.string :name
      t.integer :level, default: 0
      t.text :description
      t.string :address
      t.string :phone
      t.string :zone

      t.timestamps
    end

    add_index :motels, :address
  end
end
