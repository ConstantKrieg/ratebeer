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
end
