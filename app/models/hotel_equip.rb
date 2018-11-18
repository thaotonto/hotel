class HotelEquip < ApplicationRecord
  belongs_to :motel
  belongs_to :equipment

  validates :price, presence: true
end
