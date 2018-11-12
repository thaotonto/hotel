class Replie < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :content, presence: true
  scope :order_replies, ->{order created_at: :desc}
end
