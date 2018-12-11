class Genre < ApplicationRecord
    has_many :motels

    def self.search(search)
        where("name LIKE ?", "%#{search}%")
    end
end
