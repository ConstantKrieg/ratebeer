require 'rails_helper'

RSpec.describe Beer, type: :model do


  it "isn't saved if a name is not given" do
    beer = Beer.create style:"lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end  

  it "isn't saved if a style is not given" do
    beer = Beer.create name:"kalja"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end



  describe "with proper attributes" do
    let(:beer){Beer.create name: "kalja", style:"lager"}


    it "is saved" do 
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end


  end


    
end


