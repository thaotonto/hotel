
class Picture < ApplicationRecord
	mount_uploader :picture, PictureUploader 
	validates :picture, presence: true
    belongs_to :review
end