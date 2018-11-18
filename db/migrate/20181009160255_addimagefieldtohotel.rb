class Addimagefieldtohotel < ActiveRecord::Migration[5.2]
  def change
    add_column :motels, :images, :string
  end
end
