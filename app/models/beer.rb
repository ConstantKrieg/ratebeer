class Beer < ActiveRecord::Base
	include AverageRating
	
    validates :name, presence: true, allow_blank: false
    validates :style_id, presence: true
	

	belongs_to :brewery
	belongs_to :style
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user

	def to_s
		"#{self.name}, #{self.brewery.name}"
	end
end


