class Equipment < ApplicationRecord
  has_many :hotel_equips
  has_many :motels, through: :hotel_equips

  validates :name, presence: true
  before_save :beatify

  before_destroy do
    errors.add(:base, 'Cannot delete') if motels.any?
    throw(:abort) if errors.present?
  end

  private

  def beatify
    self.name = name.titleize
  end
  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
