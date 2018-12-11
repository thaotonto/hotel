class Motel < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :hotel_rooms, inverse_of: :motel, dependent: :destroy
  has_many :rooms, through: :hotel_rooms
  has_many :hotel_equips, inverse_of: :motel, dependent: :destroy
  has_many :equipments, through: :hotel_equips
  has_many :reviews, dependent: :destroy
  has_many :user_hotels, inverse_of: :motel, dependent: :destroy
  has_many :users, through: :user_hotels
  belongs_to :genre

  geocoded_by :address

  accepts_nested_attributes_for :hotel_equips, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :hotel_rooms, reject_if: :all_blank, allow_destroy: true
  attr_reader :point
  # mount_uploaders :images, ImagesUploader
  # serialize :images, JSON
  validates :name, presence: true
  validates :zone, presence: true
  validates :address, presence: true,
            uniqueness: {case_sensitive: false}
  validates :phone, presence: true, :numericality => true,
            :length => {:minimum => 10, :maximum => 15}
  validates :level, presence: true
  validate :validate_unique_equipment
  validate :validate_unique_room
  after_validation :geocode, :if => :address_changed?

  scope :order_level, -> {order level: :desc}

  def avarege_point
    @point = reviews.average(:rate)
    if point != nil
      point.round(1)
    else
      0
    end
  end

  def validate_unique_equipment
    validate_uniqueness_of_in_memory(
        hotel_equips, [:motel_id, :equipment_id])
  end

  def validate_unique_room
    validate_uniqueness_of_in_memory(
        hotel_rooms, [:motel_id, :room_id])
  end

  def blank_stars
    5 - star
  end

  def star
    @point = reviews.average(:rate)
    if point != nil
      point.round
    else
      0
    end
  end

  def self.search(search)
    Motel.left_outer_joins(:genre).where("motels.name LIKE :search OR motels.address LIKE :search OR motels.zone LIKE :search OR genres.name LIKE :search", search: "%#{search}%")
  end

  def self.search_zone(search)
    where("zone LIKE ?", "%#{search}%")
  end

  filterrific(
      default_filter_params: {},
      available_filters: [
          :with_all_room_id,
          :with_all_level,
          :with_all_equipment_id,
          :with_all_genre_id,
          :with_room_price_gte,
          :with_equipment_price_gte
      ]
  )

  scope :with_all_equipment_id, lambda {|equipment_ids|
    hotel_equips = HotelEquip.arel_table
    motels = Motel.arel_table
    equipment_ids.map(&:to_i).inject(self) {|rel, equipment_id|
      rel.where(
          HotelEquip \
          .where(hotel_equips[:motel_id].eq(motels[:id])) \
          .where(hotel_equips[:equipment_id].eq(equipment_id)) \
          .exists
      )
    }
  }

  scope :with_all_room_id, lambda {|room_ids|
    hotel_rooms = HotelRoom.arel_table
    motels = Motel.arel_table
    room_ids.map(&:to_i).inject(self) {|rel, room_id|
      rel.where(
          HotelRoom \
          .where(hotel_rooms[:motel_id].eq(motels[:id])) \
          .where(hotel_rooms[:room_id].eq(room_id)) \
          .exists
      )
    }
  }

  scope :with_all_genre_id, lambda {|genre_id|
      Motel.joins(:genre).where("genres.id = ? ", "#{genre_id}")
  }

  scope :with_all_level, lambda {|level|
    Motel.where("motels.level = ? ", "#{level}")
  }

  scope :with_room_price_gte, lambda { |price|
    if (price == 0)
      Motel.all
    else
      where('hotel_rooms.price BETWEEN ? AND ?', price, price+200000).joins(:hotel_rooms).distinct
    end
  }

  scope :with_equipment_price_gte, lambda { |price|
    if (price == 0)
      Motel.all
    else
      where('hotel_equips.price BETWEEN ? AND ?', price, price+5000).joins(:hotel_equips).distinct
    end
  }

end