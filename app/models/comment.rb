class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many :replies

  validates :content, presence: true
  scope :order_comment, ->{order created_at: :desc}
end
