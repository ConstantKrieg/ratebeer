class User < ActiveRecord::Base
    include AverageRating

    has_secure_password

    validates :username, uniqueness: true,
                         length: { minimum: 3, maximum: 30 }

    validates :password, length: {minimum: 4},
                format: {with: /\d[A-Z]|[A-Z].*\d/,
                message: "Your password has to contain at least one number and one letter must be upper case!"}                        

    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships, dependent: :destroy
    has_many :beer_clubs, through: :memberships

    def to_s
        self.username
    end

    def favorite_beer
        return nil if ratings.empty?
        ratings.order(score: :desc).limit(1).first.beer
    end

    def favorite_style
      return nil if ratings.empty?

      styles = ratings.map{|r| r.beer.style}
      styles.sort_by{|s| -average_style_rating(s)}.first 
    end

    def favorite_brewery
      return nil if ratings.empty?

      breweries = ratings.map{|r| r.beer.brewery }
      breweries.sort_by{|b| -average_brewery_rating(b)}.first
    end        


    def average_style_rating (style) 
        styleRatings = ratings.select{|r| r.beer.style == style}
        styleRatings.inject(0.0){|sum, n| sum + n.score} / styleRatings.count.to_f
    end

    def average_brewery_rating (brewery)
        breweryRatings = ratings.select{|r| r.beer.brewery == brewery}
        breweryRatings.inject(0.0){|sum, n| sum + n.score} / breweryRatings.count.to_f
    end    
end
