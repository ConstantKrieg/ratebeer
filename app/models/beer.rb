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

	def self.top(size)
	  sorted_by_rating = Beer.all.sort_by{|b| -average_rating_for_beer(b)}
	  sorted_by_rating.first(size)	
	end

	def self.average_rating_for_beer(beer)
	  return 0.0 if beer.ratings.empty?
	  beer.ratings.inject(0.0){|sum, n| sum + n.score} / beer.ratings.count.to_f
	end		
end


