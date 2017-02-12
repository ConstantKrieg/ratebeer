require 'rails_helper'


describe "Beer page" do 
     
  
  
  it "can create beers with proper credentials" do
    visit new_beer_path
    fill_in('beer_name', with:'Kalja')
    select('Lager', from: 'beer[style]')

    expect{
        click_button ('Create Beer')
    }.to change{Beer.count}.from(0).to(1)

    
    expect(page).to have_content 'Beer was successfully created.'

  end    
  
  it "can't create beers with inproper credentials" do
    visit new_beer_path
    fill_in('beer_name', with:'')
    select('Lager', from: 'beer[style]')

    click_button ('Create Beer')
    

    
    expect(Beer.count).to eq(0)

  end

end    