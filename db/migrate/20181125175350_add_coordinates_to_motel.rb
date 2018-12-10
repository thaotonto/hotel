class AddCoordinatesToMotel < ActiveRecord::Migration[5.2]
  def change
    add_column :motels, :latitude, :float, default: 21.03576383
    add_column :motels, :longitude, :float, default: 105.85124142
  end
end
