class Brewery < ActiveRecord::Base
	include AverageRating

	validates :name, presence: true, allow_blank: false
	validates :year, numericality: { greater_than_or_equal_to: 1042,
									   less_than_or_equal_to: ->(_brewery){Date.current.year},
                                       only_integer: true } 


	scope :active, -> {where active:true}
	scope :retired, -> {where active:[nil,false]}								   

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
    	puts name
    	puts "established at year #{year}"
    	puts "number of beers #{beers.count}"
  	end

	def restart
		self.year = 2017
		puts "changed year to #{year}"
	end

	def to_s 
	  self.name	
	end	

	def self.top(size)	
	  sorted_by_rating = Brewery.all.sort_by{|b| b.average_rating}
	  sorted_by_rating.reverse.first(size)  

	end
	

		  

end
