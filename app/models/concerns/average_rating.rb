module AverageRating
    extend ActiveSupport::Concern

    def average_rating
        return 0.0 if ratings.empty?
        ratings.inject(0.0){|sum, n| sum + n.score} / ratings.count.to_f
    
    end

    
end        