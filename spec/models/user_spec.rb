require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end


  it "is not saved with a password that's too short" do
    user = User.create username:"Pekka", password: "S1m"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password without numbers" do
    user = User.create username:"Pekka", password: "Salasana"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

 



  describe "favorite beer" do 
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "and has favorite_style" do 
      expect(user).to respond_to(:favorite_style)
    end

    it "and has favorite brewery" do 
      expect(user).to respond_to(:favorite_brewery)
    end   

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
      expect(user.favorite_style).to eq(nil)
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one has been rated" do 
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
      expect(user.favorite_style).to eq(beer.style)
      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one rated highest if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)
      
      expect(user.favorite_beer).to eq(best)
    end  

  end

  describe "favorite style" do 
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one has been rated" do 
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      
      expect(user.favorite_style).to eq(beer.style)
      
    end

    it "is the one rated highest if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)
      
      expect(user.favorite_style).to eq(best.style)
    end  

  end

  describe "favorite brewery" do 
    let(:user){FactoryGirl.create(:user) }

    
    it "has method for determining one" do 
      expect(user).to respond_to(:favorite_brewery)
    end   

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one has been rated" do 
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)


      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one rated highest if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)
      
      expect(user.favorite_brewery).to eq(best.brewery)
    end  

  end

  



    

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end 


    
