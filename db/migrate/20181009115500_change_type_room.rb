class ChangeTypeRoom < ActiveRecord::Migration[5.2]
  def change
    change_column :rooms, :type, :string
    add_index :rooms, :type, unique: true
  end
end
