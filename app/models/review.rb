class Review < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :motel

  validates :title, presence: true
  validates :rate, presence: true
  # serialize :images, JSON
  # mount_uploaders :images, ImagesUploader
  scope :order_after_like, ->{order rate: :desc}

  def blank_stars
    5 - rate.to_i
  end

  def self.search(search)
    if search
      where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%").order('id DESC')
    else
      order('id DESC')
    end
  end

end
