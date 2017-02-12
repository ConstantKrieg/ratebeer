require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user2}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "displays the correct amount of ratings" do
    visit new_rating_path
    
  
    select('iso 3, Koff', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"

    visit new_rating_path
    
    select('Karhu, Koff', from:'rating[beer_id]')
    fill_in('rating[score]', with:'10')    
    click_button "Create Rating"

    visit ratings_path

    

    expect(page).to have_content 'Number of ratings: 2'
  end

  it "displays ratings from current user on users page" do
    visit new_rating_path
    
    
    select('iso 3, Koff', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"

    create_beers_with_ratings(user2, 10, 20, 15, 7, 9)

    visit user_path(user)

    expect(page).to have_content("has made 1 rating") 
  end

  it "is deleted when user deletes it" do
    visit new_rating_path
    
    
    select('iso 3, Koff', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"

    expect{
      click_link "delete"
    }.to change{user.ratings.count}.from(1).to(0)

  end 

  it "shows favorite brewery and style of user" do
    visit new_rating_path
    select('Karhu, Koff', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"

    save_and_open_page
    expect(page).to have_content 'Favorite brewery of Pekka: Koff'
    expect(page).to have_content 'Favorite style of Pekka: Lager'
  end 
      
end