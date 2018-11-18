class HotelRoom < ApplicationRecord
  belongs_to :motel
  belongs_to :room

  validates :price, presence: true
end
