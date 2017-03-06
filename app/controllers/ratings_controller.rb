class RatingsController < ApplicationController

  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :skip_if_cached, only:[:index]

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if request.format.html? and fragment_exist?( "ratings" )
  end

  def index
    #Toteutin fragment cachingilla index sivun tallentamisen välimuistiin
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @most_active = User.most_active_users 5
    @latest = Rating.recent(5)
    @top_styles = Style.top 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    
    
    if @rating.save
      current_user.ratings << @rating
      session[:last_rating] = "#{@rating.beer.name} #{@rating.score} points"
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end  
    
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete  if current_user == rating.user
    redirect_to :back
  end

end