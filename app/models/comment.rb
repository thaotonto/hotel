class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many :feedbacks, class_name: "Replie", dependent: :destroy

  validates :content, presence: true
  scope :order_comment, ->{order created_at: :desc}
end
