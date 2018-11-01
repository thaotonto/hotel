class Equipment < ApplicationRecord
  has_many :hotel_equips
  has_many :motels, through: :hotel_equips

  validates :name, presence: true
  before_save :beatify

  private

  def beatify
    self.name = name.titleize
  end
  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
