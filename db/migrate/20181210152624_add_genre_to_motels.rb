class AddGenreToMotels < ActiveRecord::Migration[5.2]
  def change
    add_column :motels, :genre_id, :integer, default: 1
  end
end
