class PlacesController < ApplicationController


  def index
  end

  def show
    @place = BeermappingApi.places_in(session[:last_place]).select{|p| p.id == params[:id]}.first
    
  end  

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
      session[:last_place] = params[:city]
    end          
  end        
end    