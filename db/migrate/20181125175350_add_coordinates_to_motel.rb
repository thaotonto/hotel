class AddCoordinatesToMotel < ActiveRecord::Migration[5.2]
  def change
    add_column :motels, :latitude, :float
    add_column :motels, :longitude, :float
  end
end
