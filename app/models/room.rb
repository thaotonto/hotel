class Room < ApplicationRecord
  has_many :hotel_rooms
  has_many :motels, through: :hotel_rooms

  validates :room_type, presence: true,
    uniqueness: {case_sensitive: false}
  validates :bed_numbers, presence: true
  validates :guest_no, presence: true
  before_save :beatify

  before_destroy do
    errors.add(:base, 'Cannot delete') if motels.any?
    throw(:abort) if errors.present?
  end

  private

  def beatify
    self.room_type = room_type.titleize
  end

  def self.search(search)
    where("room_type LIKE ? OR bed_numbers LIKE ? OR guest_no LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
