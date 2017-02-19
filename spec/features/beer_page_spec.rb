require 'rails_helper'

include Helpers

describe "Beer page" do 
     let!(:user) { FactoryGirl.create :user }
     let!(:style) { FactoryGirl.create :style }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end
  
  
  it "can create beers with proper credentials" do
    visit new_beer_path
    fill_in('beer_name', with:'Kalja')
    select('Lager', from: 'beer[style_id]')

    expect{
        click_button ('Create Beer')
    }.to change{Beer.count}.from(0).to(1)

    
    expect(page).to have_content 'Beer was successfully created.'

  end    
  
  it "can't create beers with inproper credentials" do
    visit new_beer_path
    fill_in('beer_name', with:'')
    select('Lager', from: 'beer[style_id]')

    click_button ('Create Beer')
    

    
    expect(Beer.count).to eq(0)

  end

end    