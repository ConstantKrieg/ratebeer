class Style < ActiveRecord::Base
    include AverageRating

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def to_s 
		  self.name		
	  end

    def self.top(size)
      Style.all.sort_by{|s| s.average_rating}.reverse.first(size)
    end

      	
end
