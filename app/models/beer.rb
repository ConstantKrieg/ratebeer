class Beer < ActiveRecord::Base
	include AverageRating
	
	belongs_to :brewery
	has_many :ratings

	def to_s
		"#{self.name}, #{self.brewery.name}"
	end
end


