class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :motel_id
      t.string :image
    end
  end
end
