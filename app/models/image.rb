
class Image < ApplicationRecord
	mount_uploader :image, ImagesUploader 
	validates :image, presence: true
    belongs_to :motel
end