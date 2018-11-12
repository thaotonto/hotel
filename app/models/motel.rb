class Motel < ApplicationRecord
  has_many :hotel_rooms, inverse_of: :motel, dependent: :destroy
  has_many :rooms, through: :hotel_rooms
  has_many :hotel_equips, inverse_of: :motel, dependent: :destroy
  has_many :equipments, through: :hotel_equips
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :hotel_equips, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :hotel_rooms, reject_if: :all_blank, allow_destroy: true

  mount_uploaders :images, ImagesUploader
  serialize :images, JSON
  validates :name, presence: true
  validates :address, presence: true,
    uniqueness: {case_sensitive: false}
  validates :phone, presence: true, :numericality => true,
    :length => { :minimum => 10, :maximum => 15 }
  validates :level, presence: true
  validate :validate_unique_equipment
  validate :validate_unique_room

  def validate_unique_equipment
    validate_uniqueness_of_in_memory(
      hotel_equips, [:motel_id, :equipment_id])
  end

  def validate_unique_room
    validate_uniqueness_of_in_memory(
      hotel_rooms, [:motel_id, :room_id])
  end
  def self.search(search)
    where("name LIKE ? OR address LIKE ? OR level LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
  def self.filter(search_name, search_level, search_equipment, order_price) 
    if (order_price == "Order Price Asc")
      Motel.joins(:hotel_equips).where("name LIKE ? AND level LIKE ? AND hotel_equips.equipment_id = ?", "%#{search_name}%", "%#{search_level}%", "#{search_equipment}").order("hotel_equips.price ASC")
    elsif (order_price == "Order Price Desc")
      Motel.joins(:hotel_equips).where("name LIKE ? AND level LIKE ? AND hotel_equips.equipment_id = ?", "%#{search_name}%", "%#{search_level}%", "#{search_equipment}").order("hotel_equips.price DESC")
    else
      Motel.joins(:hotel_equips).where("name LIKE ? AND motels.level LIKE ? AND hotel_equips.equipment_id = ?", "%#{search_name}%", "%#{search_level}%", "#{search_equipment}")
    end
  end
  def self.search_name_level(search_name, search_level)
    where("name LIKE ? AND level LIKE ?", "%#{search_name}%", "%#{search_level}%")
  end
end
